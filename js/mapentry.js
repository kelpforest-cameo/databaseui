//TODO: generic spatial info in database (i.e.location may be one of these categories, a lat/lon point, or an arbitrary polygon
// 			this refers to the location_data table that links observations/nodes to the location categories
var MODE_RANGE=0,MODE_LOCATION=1;
function MapEntry() {  

	var that = this;
	this.id= "map_interface";
	this.initialized = false;
	this.element = document.createElement("div");
	this.element.setAttribute('id', this.id);
	this.element.setAttribute('title', "Map Entry");
	this.pacContainerInit = false;
	$(this.element).css("padding","2px");
	$(this.element).css("overflow","hidden");
	$(this.element).hide();

	this.table='locations';
	this.zoomTarget = -1;
	this.map = null;
	this.drawControls = null;
	this.vectors = null;
	this.loaded_nodes = [];
	this.select_node = null;
	this.mapClicked = false;
	this.featureEvent = true;
	this.dialogResult = null;
	this.dlgCallback = null;
	this.coordinates = null;
	this.mode = MODE_LOCATION;
	this.location_id = -1;
	OpenLayers.Feature.Vector.style['default']['strokeWidth'] = '2';


	var html = "<div id=\"map_container\" style=\"background-color: black; width: 875px; height: 500px\">" +
		"<div id=\"map_wrap\" style=\"margin: 10px; width:640px; height:480px;float:left;border: 1px solid black;\"><div id=\"map_canvas\" style=\"width: 100%; height: 100%\"></div></div>" +
		"<div id=\"sidebar\" style=\"width: 200px; height: 480px; background-color: white; float:left; margin-top: 10px; margin-bottom: 10px\">" +
			"<div id=\"tree\" style=\"width: 100%; height: 87%; overflow: auto\"></div>" +
			"<div id=\"nav\" style=\"height: 100%; margin-top: 5px\">" +
				"<form id=\"llform\"><input style=\"background-color: white; border: 1px solid black; width: auto;\" type=\"text\" id=\"lat\" size=8 value=\"lat\" title=\"lat\">&nbsp;<input style=\"background-color: white; border: 1px solid black; width: auto;\" type=\"text\" id=\"lon\" size=\"8\" value=\"lon\" title=\"lon\">&nbsp;<input style=\"background-color: white; border: 1px solid black; width: auto;\" type=submit value=\"go\"></form>" +
				"<form id=\"searchform\" method=\"get\"><input style=\"background-color: white; border: 1px solid black; width: auto;\" type=\"text\" id=\"mapsearch\" size=22 value=\"search map\" title=\"search map\">&nbsp;<input style=\"background-color: white; border: 1px solid black; width: auto;\" type=submit value=\"go\"></form>" +
			"</div>" +
		"</div>" +
	"</div>";
	$(this.element).append(html);
	$(this.element).appendTo('body');

	$( this.element ).dialog({
		autoOpen: false,
		title: "Map Entry",
		height: 'auto',
		width: 'auto',
		shadow: false,
		modal: false,
		resizable: false,
		buttons: {
			"Select": function() {
				$(that.element).dialog('close');
				if (that.dlgCallback != null && that.dlgCallback != undefined && typeof(that.dlgCallback) == 'function') {
					that.dlgCallback(that.dialogResult);
				}
			},
			"Cancel": function() { $(that.element).dialog('close'); }
		},
		open: function(e,u) {
			if (!that.initialized) {
				that.initialized = true;
				that.initializeMap();
				that.initializeUI();
			}
			var t = $(that.element).dialog('option','title');
			switch (that.mode) 
			{
			case MODE_LOCATION:
				that.drawControls.select.toggleKey = null;
				that.drawControls.select.multipleKey = null;
				t += ' - Select Location';
				break;
			case MODE_RANGE:
				that.drawControls.select.toggleKey = "ctrlKey";
				that.drawControls.select.multipleKey = "shiftKey";
				t += ' - Select Range';
				break;
			}
			that.setTitle(t);
			that.setStatus(t);
			//--------------------------------------------------
			// $("<div>"+t+"</div>").css('float','left').css('border','1px solid black').css('height',ht).prependTo('.ui-dialog-buttonpane');
			//-------------------------------------------------- 
		}
	});
}

MapEntry.prototype.setTitle = function(t)
{
	$(this.element).dialog('option','title',t);
}

MapEntry.prototype.setStatus = function(t)
{
	if ($("#statusbox").length) {
		$("#statusbox").html(t);
	} else {
		var ht = $('.ui-dialog-buttonset').innerHeight();
		var outer = $("<div>").css({
			'display': 'table',
			'height': ht,
			'#position': 'relative',
			'overflow': 'hidden',
			'float': 'left'
		});
		var middle = $("<div>").css({
			'#position': 'absolute',
			'#top': '50%',
			'display': 'table-cell',
			'vertical-align': 'middle'
		});
		$("<div>"+t+"</div>").css({
			'#position': 'relative',
			'#top': '-50%'
		}).attr('id','statusbox').appendTo(middle);
		$(middle).appendTo(outer);
		$(outer).prependTo('.ui-dialog-buttonpane');
	}
}

MapEntry.prototype.getLocation = function() {
	var that = this;
	return { 
		id: that.location_id,
		name: $("#node_"+that.location_id).text().trim()
	};
}

MapEntry.prototype.open = function (mode, done) {

	this.dlgCallback = done;
	this.mode = mode;
	if ( $(this.element).dialog( "isOpen" ) === true ) {
		return;
	}
	$(this.element).dialog('open');
}

MapEntry.prototype.updateMap = function()
{
	var that = this;
	var b = this.map.getExtent();
	b.transform("EPSG:3857","EPSG:4326");
	removedList = this.pruneFeatures(b);
	$.get("map.php",
		{
			'op': 'visible_regions', 
			'bbox': b.toBBOX(), 
			'zoom': this.map.getZoom(),
			'table': this.table,
			'exclude': removedList
		},
		function(data) {
			var toSelect = null;
			for (i in data) {
				var feature = that.createFeature(data[i]);
				that.vectors.addFeatures([feature]);
				if (that.select_node != null && feature.attributes.region_id == that.select_node) {
					toSelect = feature;
					that.select_node = null;
				}
			}
			if (that.select_node != null) {
				toSelect = that.getLayer(that.select_node);
				that.select_node = null;
			}
			if (toSelect) {
				that.featureEvent = false;
				that.drawControls.select.unselectAll();
				that.drawControls.select.select(toSelect);
			}
		},
		"json"
	);
}

MapEntry.prototype.createFeature = function(data)
{
	var box = OpenLayers.Geometry.fromWKT(data.envelope).getBounds();
	var centroid = OpenLayers.Geometry.fromWKT(data.centroid);

	var feature = new OpenLayers.Feature.Vector(
		OpenLayers.Geometry.fromWKT(data.region).transform("EPSG:4326","EPSG:3857"),
		{
			'region_id': data.id, 
			'parent_region': data.parent,
			'centroid': centroid,
			'bounding_box': box, 
			'zoom_range': {'min': data.zoom_min, 'max': data.zoom_max},
			'rank': data.rank,
			'color': "#45A818",
			'zIndex': data.z_index,
			'visible': data.visible
		}
	);
	return feature;
}

MapEntry.prototype.pruneFeatures = function(bounds)
{
	var zoom = this.map.getZoom();
	var exclude = [], remove = [];
	for (i in this.vectors.features)
	{
		var f = this.vectors.features[i];
		if (!bounds.intersectsBounds(f.attributes.bounding_box) || (zoom < f.attributes.zoom_range.min || zoom > f.attributes.zoom_range.max)) {
			remove.push(f);
		} else {
			exclude.push(f.attributes.region_id);
		}
	}
	this.vectors.removeFeatures(remove,{silent: true});
	return exclude;
}

MapEntry.prototype.getLayer = function(id)
{
	for (i in this.vectors.features)
	{
		if (this.vectors.features[i].attributes.region_id == id) 
			return this.vectors.features[i];
	}
	return null;
}


MapEntry.prototype.initializeMap = function() 
{
	var that = this;
	this.map = new OpenLayers.Map('map_canvas');
	wkt = new OpenLayers.Format.WKT();
	var wmsLayer = new OpenLayers.Layer.WMS(
		"OpenLayers WMS", 
		"http://vmap0.tiles.osgeo.org/wms/vmap0",
		{layers: 'basic'}
	); 
	//TODO: more map layers from Google? (street, hybrid, etc.)
	var satLayer = new OpenLayers.Layer.Google("Google Satellite",{
			'type': google.maps.MapTypeId.SATELLITE, 
			'numZoomLevels': 22,
			'sphericalMercator': true,
			'maxExtent': new OpenLayers.Bounds(-20037508.34, -20037508.34, 20037508.34, 20037508.34)
			});


	// allow testing of specific renderers via "?renderer=Canvas", etc
	var renderer = OpenLayers.Util.getParameters(window.location.href).renderer;
	renderer = (renderer) ? [renderer] : OpenLayers.Layer.Vector.prototype.renderers;

	var context = {
		getColor: function(f,s) {
			if (f.attributes.zoom_range.min == -1) {
				return "#ee9900";
			}	else if (f.attributes.zoom_range.min == 6) {
				return "#45A818";
			} else if (f.attributes.zoom_range.min > 6) {
				return "#F0307D";
			}
		},
		getZIndex: function(f,s) {
			return f.attributes.zIndex;
		},
		getOpacity: function(f,s) {
			return f.attributes.zIndex == 1 ? 0.4 : 1.0;
		}
	};
	var template = {
		fillColor: "${getColor}",
		strokeColor: "${getColor}",
		graphicZIndex: "${getZIndex}",
		fillOpacity: "${getOpacity}"
	};
	var style = new OpenLayers.Style(template,{context: context});

	this.vectors = new OpenLayers.Layer.Vector("Vector Layer", 
		{
			styleMap: new OpenLayers.StyleMap({
				'default': style,
				'select': {
					fillColor: 'blue',
					strokeColor: 'blue',
					fillOpacity: 0.4,
					zIndex: "${zIndex}"
				}
			}),
			rendererOptions: {zIndexing: true},
			renderers: renderer
		}
	);
	this.vectors.events.on({
		'featureselected': function(feature) {
			if (that.featureEvent) {
				that.layerSelect(feature);
			} else {
				that.featureEvent = true;
			}
		},
		'featureunselected': function(feature) {
			if (that.vectors.selectedFeatures.length == 0) {
				that.location_id = -1;
			}
		}
	});

	this.map.events.on({
		'moveend': function(e) {
			that.updateMap();
		},
		'zoomend': function(e) {
		}	
	});

	//map.addLayers([wmsLayer, this.vectors]);
	this.map.addLayers([satLayer, this.vectors]);
	this.map.addControl(new OpenLayers.Control.LayerSwitcher());

	this.drawControls = {
		select: new OpenLayers.Control.SelectFeature(
			this.vectors,
			{
				clickout: true, toggle: false,
				multiple: false, hover: false,
				box: false
			}
		)
	};

	for(var key in this.drawControls) {
		this.map.addControl(this.drawControls[key]);
	}
	this.map.setCenter(new OpenLayers.LonLat(-122.030796, 36.974117).transform("EPSG:4326","EPSG:3857"),3);
	this.drawControls.select.activate();
}


MapEntry.prototype.initializeUI = function()
{
	var ajax_data = null;
	var that = this;

	$("#tree").jstree({
		"plugins" : [ "json_data","ui","themes","hotkeys","search" ],
		"json_data" : {
			"ajax" : {
				"url" : "map.php",
				"data" : function(n) {
					return {
						"op": "get_children",
						"id" : n.attr ? n.attr("id").replace("node_","") : 1,
						'table': that.table
					};
				},
				"success": function(data) {
					ajax_data = data;
				}
			}
		},
		"themes" : {
			"theme" : "classic",
			"dots" : true,
			"icons" : false
		},
		"search" : {
			"ajax" : {
				"url": "map.php",
				"data": function(str) {
					return {
						"op": "search",
						"srch": str,
						'table': that.table
					}
				}
			}	
		},
		"core" : {
			"animation" : 100
		},
		"ui" : {
			"select_multiple_modifier": false,
			"select_limit" : 1
		}
	}).bind("select_node.jstree",function(e,data) {
		that.nodeSelect(data);
	}).bind("load_node.jstree",function(e,data) {
		var loaded = data.inst._get_children(data.rslt.obj);
		for (var i=0; i<loaded.length; i++) {
			$(loaded[i]).data('node_info',ajax_data[i]);
		}
	}).bind("search.jstree",function(e,data) {
		if (data.args.length) {
			var id = data.args[0];
			if ($("#node_"+id).length) {
				$("#tree").jstree("select_node","#node_"+id,true,false);
			}
		}
	});
	$("input[type=text]").focus(function() {
		if ($(this).val() == $(this).attr('title'))
			$(this).val('');
	}).blur(function() {
		if ($(this).val() == '')
			$(this).val($(this).attr('title'));
	});
	$("#llform").submit(function(e) {
		var lt = parseFloat($("#lat").val());
		var ln = parseFloat($("#lon").val());
		if ((lt >= -90 && lt <= 90) && (ln >= -180 && ln <= 180)) {
			that.coordinates = new OpenLayers.LonLat(ln,lt);
			that.map.setCenter(that.coordinates.clone().transform("EPSG:4326","EPSG:3857"),7);
		}
		e.preventDefault();
	});
	$("#mapsearch").geocomplete().bind("geocode:result",function(e,result) {
		var loc = result.geometry.location;
		that.coordinates = new OpenLayers.LonLat(loc.lng(),loc.lat());
		that.map.setCenter(that.coordinates.clone().transform("EPSG:4326","EPSG:3857"),7);
	}).keypress(function() {
		if (!that.pacContainerInit) {
			$('.pac-container').css('z-index','10000');
			$('.pac-container').css('min-width','300px');
			that.pacContainerInit = true;
		}
	});
}

MapEntry.prototype.nodeSelect = function(data)
{
	this.location_id = $(data.rslt.obj).attr('id').replace('node_','');
	if (!this.mapClicked)
	{
		this.select_node = $(data.rslt.obj).attr('id').replace('node_','');
		try { 
			var info = $(data.rslt.obj).data('node_info');
			var zoom = this.map.getZoom();
			zoom = (zoom >= info.zoom_min && zoom <= info.zoom_max) ? zoom : info.zoom_min;
			if (zoom == -1) zoom = 3;
			var g = OpenLayers.Geometry.fromWKT(info.centroid);
			this.coordinates = new OpenLayers.LonLat(g.x,g.y);
			this.map.setCenter(this.coordinates.clone().transform("EPSG:4326","EPSG:3857"),zoom);
		}	catch (e) {}
	}
	else this.mapClicked = false;
}

MapEntry.prototype.layerSelect = function(feature)
{
	this.mapClicked = true;
	var lyr = feature.feature;
	this.coordinates = new OpenLayers.LonLat(lyr.attributes.centroid.x,lyr.attributes.centroid.y);
	if ($("#node_"+lyr.attributes.region_id).length) {
		$("#tree").jstree('select_node','#node_'+lyr.attributes.region_id,true,false);
	} else {
		var srch_id = (lyr.attributes.visible == 1) ? lyr.attributes.region_id : lyr.attributes.parent_region;
		$("#tree").jstree('search',srch_id);	
	}
}
