function Comment(  ) {
	//this.container = document.createElement('div');
	//$(this.container).css( "display", "inline-block" );
	this.button = document.createElement('button');
	this.button.setAttribute('title', "Add a comment to this data entry");
	$(this.button).button(  { icons: {primary:'ui-icon-comment'}, text: false } );
	$(this.button).tipTip()
	$(this.button).css( "padding", "3px" );
	$(this.button).click( createMethodReference(this, "openDialog") );

	this.bgcol = this.button.style.background;

	this.textarea = document.createElement('textarea');
	this.textarea.setAttribute("rows", 5);
}

Comment.prototype.addComment = function() {
	$(this.dialog).dialog("close");
	$(this.dialog).remove();
	this.dialog = undefined;

	if ( $.trim($(this.textarea).val()) != "") {
		this.button.style.background="#990000";
	} else {
		this.button.style.background= this.bgcol;
	}

}
Comment.prototype.openDialog = function() {
	this.dialog = document.createElement("div");
	this.dialog.setAttribute("title", "Set comment");
	this.dialog.appendChild( this.textarea );
	$(this.dialog).dialog({ 
		width: 300, 
		closeOnEscape: true, 
		modal: true,
		close: function() { $( this ).remove(); },
		buttons: { 
			"Add Comment" : createMethodReference(this, "addComment"),
			"Close": function() {$( this ).remove(); }
		} 
	});
}
Comment.prototype.clear = function() {
	this.textarea.value = "";
	this.button.style.background= this.bgcol;
}
Comment.prototype.getComment = function() {
	if (this.textarea != undefined && $.trim($(this.textarea).val()) != ""){
		return this.textarea.value;
	}
	return;
}

function Datum(  ) {
	this.button = document.createElement('button');
	this.button.setAttribute('title', "Add a date to this data entry");
	$(this.button).button(  { icons: {primary:'ui-icon-clock'}, text: false } );
	$(this.button).tipTip()
	$(this.button).css( "padding", "3px" );
	$(this.button).click( createMethodReference(this, "openDialog") );

 	this.bgcol = this.button.style.background;
	this.type = "year";
	this.number = 1;
}

Datum.prototype.setYear = function( ){
	if (this.type != "year") {
		this.type = "year";
		this.values = undefined;
		this.makeWidgets();
	}
}
Datum.prototype.setMonth = function(  ){
	if (this.type != "month") {
		this.type = "month";
		this.values = undefined;
		this.makeWidgets();
	}
}
Datum.prototype.setSeason = function( ){
	if (this.type != "season") {
		this.type = "season";
		this.values = undefined;
		this.makeWidgets();
	}
}
Datum.prototype.setDate = function( ){
	if (this.type != "date") {
		this.type = "date";
		this.values = undefined;
		this.makeWidgets();
	}
}

Datum.prototype.getDatum = function() {
	if (this.values != undefined) {
		if (this.type == "year"){
			return { type : "year", values : this.values }
		} else if (this.type == "month") {
			return { type : "month", values : this.values }
		} else if (this.type == "season") {
			return { type : "season", values : this.values }
		} else if (this.type == "date") {
			return { type : "date", values : this.values }
		}
	}
	return undefined;
}

Datum.prototype.clear = function() {
	this.button.style.background= this.bgcol;
	this.values = undefined;
	this.number = 1;
	this.type = "year";
	$(this.widgets).remove();
	$(this.dialog).dialog("close");
	$(this.dialog).empty();
	$(this.dialog).remove();

	this.dialog = undefined;
	this.widgets = undefined;
}

Datum.prototype.setDatum = function() {
	this.button.style.background="#990000";
	this.values = new Array();
	for (var i=0; i< this.number; i++) {
		this.values[i] = $(this.widgets[i]).val();
	}
	$(this.widgets).remove();
	$(this.dialog).dialog("close");
	$(this.dialog).empty();
	$(this.dialog).remove();

	this.dialog = undefined;
	this.widgets = undefined;
}

Datum.prototype.createRadioButton = function(num, name) {
	var but= document.createElement('input');
	but.type = "radio";
	but.name = name;
	but.id = name + num;
	but.style.width = "auto";
	but.style.float ="none";
	return but;
}
Datum.prototype.createRadioLabel = function(num, name, text) {
	var l = document.createElement('label');
	l.setAttribute("for", name + num);
	$(l).text( text );
	l.style.width = "auto";
	l.style.float ="none";
	return l;
}

Datum.prototype.openDialog = function() {
	$(this.dialog).remove();
	this.dialog = document.createElement("div");
	this.dialog.setAttribute("title", "Set Date");

	this.makeWidgets();

	
	$(this.dialog).dialog({ 
		width: 400, 
		closeOnEscape: true, 
		modal: true,
		close: function() { $( this ).remove(); },
		buttons: { 
			"Set Date Info" : createMethodReference(this, "setDatum"),
			"Clear" : createMethodReference(this, "clear"),
			"Close": function() {$( this ).remove(); }
		} 
	});

}

Datum.prototype.setSingle = function( e ){
	if (this.number == 2) {
		this.number=1;
		console.log(this);
		if (this.values != undefined) 
			this.values = this.values.slice(0, 1);
		this.makeWidgets();
	}
}

Datum.prototype.setRange = function( e ){
	if (this.number ==1) {
		this.number =2;
		this.makeWidgets();
	}
}

Datum.prototype.makeWidgets = function( e ){
	$(this.dialog).empty();
	// always destroy and recreate the widgets
	this.widgets = new Array();	

	var number_div= document.createElement('div');
	number_div.style.marginBottom = "20px";
	$(this.dialog).append(number_div);
	
	var type_div= document.createElement('div');
	$(this.dialog).append(type_div);

	set_single_but = this.createRadioButton(1, "number");
	set_single_label = this.createRadioLabel(1, "number", "single");
	if (this.number == 1) set_single_but.checked = "checked";
	set_range_but = this.createRadioButton(2, "number");
	set_range_label = this.createRadioLabel(2, "number", "range");
	if (this.number == 2) set_range_but.checked = "checked";

	set_year_but = this.createRadioButton(1, "type");
	set_year_label = this.createRadioLabel(1, "type", "year");
	set_month_but = this.createRadioButton(2, "type");
	set_month_label = this.createRadioLabel(2, "type", "month");
	set_season_but = this.createRadioButton(3, "type");
	set_season_label = this.createRadioLabel(3, "type", "season");
	set_date_but = this.createRadioButton(4, "type");
	set_date_label = this.createRadioLabel(4, "type", "date");

	$(number_div).append( set_single_but );
	$(number_div).append( set_single_label );
	$(number_div).append( set_range_but );
	$(number_div).append( set_range_label );

	$(type_div).append( set_year_but );
	$(type_div).append( set_year_label );
	$(type_div).append( set_month_but );
	$(type_div).append( set_month_label );
	$(type_div).append( set_season_but );
	$(type_div).append( set_season_label );
	$(type_div).append( set_date_but );
	$(type_div).append( set_date_label );

	for(var i=0; i < this.number; i++) {
		if (this.type == "year") {
			set_year_but.checked = "checked";
			this.widgets[i] = document.createElement('input');
			this.widgets[i].className = "medium";
		} else if ( this.type == "month") {
			set_month_but.checked = "checked";
			this.widgets[i] = document.createElement('select');
			this.widgets[i].className = "medium";
			var marray = Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
			for( var m in marray) {
				var opt = document.createElement('option');
				opt.value = m;
				$(opt).text( marray[m] );
				$(this.widgets[i]).append(opt);
			}
		} else if (this.type == "season") {
			set_season_but.checked = "checked";
			this.widgets[i] = document.createElement('select');
			this.widgets[i].className = "medium";
			var marray = Array("Winter", "Spring", "Summer", "Autumn");
			for( var m in marray) {
				var opt = document.createElement('option');
				opt.value = m;
				$(opt).text( marray[m] );
				$(this.widgets[i]).append(opt);
			}
		} else if (this.type == "date") {
			set_date_but.checked = "checked";
			this.widgets[i] = document.createElement('input');
			this.widgets[i].className = "medium";
			$( this.widgets[i] ).datepicker(  { dateFormat : "yy-mm-dd", showOtherMonths: true,
				selectOtherMonths: true, changeMonth: true, changeYear: true} );
		}
	}

	$(number_div).buttonset();
	$(type_div).buttonset();

	$(set_range_label).click( createMethodReference(this, "setRange" ) );
	$(set_single_label).click( createMethodReference(this, "setSingle" ) );

	$(set_month_label).click( createMethodReference(this, "setMonth" ) );
	$(set_year_label).click( createMethodReference(this, "setYear" ) );
	$(set_season_label).click( createMethodReference(this, "setSeason" ) );
	$(set_date_label).click( createMethodReference(this, "setDate" ) );
	
	var table = document.createElement('table');
	table.style.marginBottom = "20px";
	var tr = document.createElement('tr');
	$(table).append( tr );
	$(table).css("margin-top", "20px");

	for(var i=0; i < this.number; i++) {
		var td = document.createElement('td');
		var td = document.createElement('td');
		$(td).text( capitalize(this.type) +" :");
		$(tr).append( td );
		var td2 = document.createElement('td');
		$(td2).append(this.widgets[i]);
		$(tr).append( td2 );
	}
	$(this.dialog).append( table);

	if (this.values != undefined) {
		for (var i=0; i < this.number; i++) {
			$(this.widgets[i]).val( this.values[i]);
		}
	}
}

// type can be: text, number, select, button, textarea, div, length_measure (or some other aggregate)
function Input( p, field_name, type ) {
	this.parent = p;  // either the NodeDialog or StageTab object
	if (this.parent != undefined && this.parent.id != undefined) {
		this.id = this.parent.id + "_" + field_name;
	}
	this.field_name = field_name;
	this.display_name = "";
	this.tooltip = "";
	if(type == undefined)  {
		this.element = document.createElement( "input" );
		this.type = "text";
	} else if ( type == "number") {
		this.element = document.createElement( "input" );
		this.type = "number";
	} else if ( type == "select") {
		this.element = document.createElement( "select" );
		this.type = "select";
	} else if ( type == "button") {
		this.element = document.createElement( "button" );
		this.type = "button";
	} else if ( type == "textarea") {
		this.element = document.createElement( "textarea" );
		this.type = "textarea";
	} else if ( type == "div") {
		this.element = document.createElement( "div" );
		this.type = "div";
	} else if ( type == "checkbox") {
		this.element = document.createElement( "input" );
		this.element.type = "checkbox";
		this.type = "checkbox";
	} else if ( type == "length_measure") {
		this.element = document.createElement( "select" );
		this.type = "length_measure";
	} else {
		this.element = document.createElement( "input" );
		this.type = "text";
	}
}

Input.prototype.createTableRow = function(  el  ) {

	this.container = document.createElement('tr');
	this.container.setAttribute('id', this.id + "_container");

	this.label = document.createElement('td');
	$(this.label).html( this.display_name );
	this.label.setAttribute('align', "right");
	this.label.setAttribute('valign', "top");
	this.label.style.paddingTop = "2px";

	this.element_td  = document.createElement('td');
	this.element_td.setAttribute('align', "left");
	this.element_td.setAttribute('valign', "top");
	this.element_td.appendChild(this.element);

	this.container.appendChild(this.label);
	this.container.appendChild(this.element_td);
	//this.container.appendChild(document.createElement('td'));
	if (el == undefined) {
		alert("Input object requrires a parent.element");
	} else {
		el.appendChild( this.container );
	}

	this.init();
} 

Input.prototype.createDivRow = function( el  ) {

	this.container = document.createElement('div');
	this.container.setAttribute('class', "divpad");
	this.container.setAttribute('id', this.id + "_container");

	this.label = document.createElement('label');
	$(this.label).html(this.display_name );
	this.label.setAttribute('for', this.id);

	this.container.appendChild(this.label);
	this.container.appendChild(this.element);
	if (el == undefined) {
		alert("Input object requrires a parent.element");
	} else {
		el.appendChild( this.container );
	}

	this.init();
}

Input.prototype.createDivRowInfo = function( el  ) {
	this.createDivRow( el) ;	
	this.container.setAttribute('class', "infoinputdiv");
	this.element.setAttribute('readonly', "true");
}

Input.prototype.createTableRowInfo = function( el  ) {
	this.createTableRow( el) ;	
	this.container.setAttribute('class', "infoinputdiv");
	this.element.setAttribute('readonly', "true");
}


Input.prototype.init = function(  ) {

	if (this.autocomplete_source != undefined && this.autocomplete_cb != undefined ) {
		$( this.element ).autocomplete({
			minLength: 3,
			select: this.autocomplete_cb,
			source: makeAutocompleteFunc( this.autocomplete_source ) // makeAutocompleteFunc is from utils.js
		});
	}

	if (this.tooltip != "") {
		this.element.setAttribute('title', this.tooltip);
		$( this.element ).tipTip();
	}
}

Input.prototype.clear = function(  ) {
	var nname = this.element.nodeName.toLowerCase();
	if( nname == "div" ) {
		$(this.element).html("");
	}
	if( nname == "input" || nname == "textarea" ) {
		if (nname == "input" && this.element.checked) {
			this.element.checked = false;
		}
		this.element.value = "";
	}
	if( nname == "select" ) {
		this.element.selectedIndex = 0;
	}
	if (this.type == "length_measure") {
		if (this.a != undefined) this.a.value = "";
		if (this.b != undefined) this.b.value = "";
	}
}

Input.prototype.hide = function(  ) {
	if (this.container != undefined) {
		this.container.style.visibility = "hidden";
		this.container.style.display = "none";
	}
}

Input.prototype.show = function(  ) {
	if (this.container != undefined) {
		this.container.style.visibility = "visible";
		this.container.style.display = "block";
	}
}


Input.prototype.setSelect = function (select_array) {
	// if there is a select array, we will draw a select form 
	// with the array elements as its options
	if (select_array != undefined) {
		$(this.element).append( document.createElement("option"));
		for (var i=0;i< select_array.length;i++) {	
			var opt = select_array[i];
			var option = document.createElement("option");
			if (typeof ( opt ) == "object") {
				// this is for display_options.locations and display_options.functional_groups
				// for locations, we want to make the spaces on the front of the names have a
				// mandatory space.  normally, the space doesn't show up in the drop down 
				// list without the &nbsp; in the  <option>
				$(option).val( opt.id);
				$(option).text(  opt.name.replace("     ", " &nbsp; ") );
			} else {
				$(option).val( opt);
				$(option).text(  opt );
			}
			$(this.element).append(option);
		}
	}
}

Input.prototype.setButton = function ( button_label, method ) {
	this.element = document.createElement('button');
	this.element.setAttribute('id', this.id);
	$( this.element ).text( button_label);
	$( this.element ).button();
	$( this.element ).click( method );
}

Input.prototype.setDiv = function () {
	this.element.style.display ="inline";
}


// used in getItisCommonNames 
Input.prototype.getCommonNamesFromDataAsString = function(data) { 
	valstring='';
	var first = true;
	if (data.return != undefined  && data.return.commonNames != undefined ){
		if (data.return.commonNames instanceof Array) {
			for (var n=0; n < data.return.commonNames.length;n++) {
				if (first) first=false;
				else valstring+=", ";
				valstring +=  data['return']['commonNames'][n]['commonName'];
			}
		} else if ( data.return.commonNames instanceof Object) {
			valstring +=  data.return.commonNames.commonName;
		}
		if (valstring =='')
			return "none";
		else
			return valstring;
	}
}

// use this function to retrieve Itis Common Names from 
// the Itis DB. A node may have more than one name.
//  is_val tells whether or not to set the 
// "val" on the element id or to set the "html"  
Input.prototype.getItisCommonNames = function( itis_id ) {
	var postdata = Object();
	postdata.functionName = "getCommonNamesFromTSN";
	postdata.tsn= itis_id;
	this.bg = this.element.style.background;
	this.element.style.background = "#ffffff url('css/ui-anim_basic_16x16.gif') right top no-repeat";
	$.ajax( { async:true, type:"GET", dataType:"json",
		data: postdata, 
		url: "auto/itis.php", 
		error : function (data, t, errorThrown) { alert("error (" + t + "):" + errorThrown); },
		success: createMethodReference(this, "getItisCommonNamesCB") 
	});
}

Input.prototype.getItisCommonNamesCB = function( data, t, x) {
	if (data == null || data == undefined) {
		alert("Error on getItisCommonNames, no response from server." );
	} else {			
		var retstring = this.getCommonNamesFromDataAsString(data);
		this.element.value = retstring;
		this.element.style.background = this.bg;
		if (this.onchange != undefined)
			this.onchange();
	}
}

Input.prototype.getItisLatinNameCB = function( data, t, x) {
	if (data == null || data == undefined) {
		alert("Error on getItisLatinName, no response from server." );
	} else {			
		var retstring = data.return.combinedName;
		this.element.value = retstring;
		this.element.style.background = this.bg;
		if (this.onchange != undefined)
			this.onchange();
	}
}
// use this function to retrieve Itis Latin/Scientific Name from 
// the Itis DB. It can only be one name.  
// is_val tells whether or not to set the 
// "val" on the element id or to set the "html" 
Input.prototype.getItisLatinName = function ( itis_id ) {
	var postdata = Object();
	postdata.functionName = "getScientificNameFromTSN";
	postdata.tsn= itis_id;
	this.bg = this.element.style.background;
	this.element.style.background = "#ffffff url('css/ui-anim_basic_16x16.gif') right top no-repeat";
	$.ajax( { async:true, type:"GET", dataType:"json",
		data: postdata, 
		url: "auto/itis.php", 
		error : function (data, t, errorThrown) { alert("error (" + t + "):" + errorThrown); },
		success: createMethodReference(this , "getItisLatinNameCB")
	});
}


Input.prototype.check = function() {
	if (this.element.value == "") {
		return true;
	} else	if (this.type == "text") {
		// do nothing, we accept everything in this case
		return true;
	} else if ( this.type == "number") {
		if ( !isNumber( this.element.value ) ) {
			alert( this.display_name + " needs to be a numeric input");
			return false;
		}
	} else if ( this.type == "length_measure") {
		if ( this.element.value.slice(0, 11) != "none exists") {
			if (this.a == undefined || this.b == undefined || this.a.value == "" || this.b.value == "" || !isNumber(this.a.value) || !isNumber(this.b.value) ) {
				alert( this.display_name + " needs both 'A' and 'B' values to determine the length relationship measure. Both 'A' and 'B' must be numeric values.");
				return false;
			}
		}
	}
	return true;
}


CiteInput.prototype = new Input();
CiteInput.prototype.constructor = CiteInput;

function CiteInput( p, field_name, type) {
	Input.call(this, p, field_name, type);

	if (type != 'button') {
		this.element.setAttribute("class", "medium");
	} else {
		$(this.element).css('width','120px');
		$(this.element).css('margin-right','2px');
	}

	this.citedvars = document.createElement('td');
	this.citedvars.setAttribute('align', "left");
	this.citedvars.setAttribute('valign', "top");
	$(this.citedvars).html( " &nbsp; ");

	this.comment = new Comment();
	this.datum = new Datum();

}

CiteInput.prototype.clear = function(  ) {
	Input.prototype.clear.call(this);
	this.comment.clear();
	this.datum.clear();
}

CiteInput.prototype.createTableRow = function( el ) {
	//Input.prototype.createTableRow.call(this, el);

	this.container = document.createElement('tr');
	this.container.setAttribute('id', this.id + "_container");

	this.label = document.createElement('td');
	$(this.label).html( this.display_name );
	this.label.setAttribute('align', "right");
	this.label.setAttribute('valign', "top");
	this.label.style.paddingTop = "2px";

	this.element_td  = document.createElement('td');
	this.element_td.setAttribute('align', "left");
	this.element_td.setAttribute('valign', "top");
	this.element_td.appendChild(this.element);

	this.container.appendChild(this.label);
	this.container.appendChild(this.element_td);

	var comment_td = document.createElement('td');
	comment_td.setAttribute('align', "left");
	comment_td.setAttribute('valign', "top");
	this.container.appendChild(comment_td);

	var datum_td = document.createElement('td');
	datum_td.setAttribute('align', "left");
	datum_td.setAttribute('valign', "top");
	this.container.appendChild(datum_td);

	this.status_td = document.createElement('td');
	this.container.appendChild(this.status_td);
	$(this.status_td).hide();

	comment_td.appendChild( this.comment.button );
	datum_td.appendChild( this.datum.button );

	this.container.appendChild(this.citedvars);

	this.container.appendChild(document.createElement('td'));
	if (el == undefined) {
		alert("Input object requrires a parent.element");
	} else {
		el.appendChild( this.container );
	}


	if (this.type != 'button') {
		this.element.setAttribute("class", "medium");
	} else {
		$(this.element).css('width','120px');
		$(this.element).css('margin-right','2px');
	}

	if (this.type == "length_measure") {
		this.a_label = document.createElement('span');
		$(this.a_label).text("A:");
		this.a_label.style.paddingRight = "4px";
		this.a = document.createElement('input');
		this.a.setAttribute('id', this.id + "_a");
		this.a.setAttribute('title', "A");
		this.a.setAttribute('type', 'text');
		this.a.style.width = '30px';
		this.a.style.paddingRight = "4px";

		this.b_label = document.createElement('span');
		$(this.b_label).text( "B:" );
		this.b_label.style.paddingRight = "4px";
		this.b_label.style.paddingLeft = "4px";
		this.b = document.createElement('input');
		this.b.setAttribute('id', this.id + "_b");
		this.b.setAttribute('title', "B");
		this.b.setAttribute('type', 'text');
		this.b.style.width = '30px';

		// we will just assume a TD here
		if (this.element_td != undefined) {
			$(this.element_td).empty();
			this.element_td.appendChild(this.element);
			this.element.style.marginBottom = "2px" ;
			this.element_td.appendChild( document.createElement('br') );
			this.element_td.appendChild(this.a_label);
			this.element_td.appendChild(this.a);
			this.element_td.appendChild(this.b_label);
			this.element_td.appendChild(this.b);
		}
	}

	this.init();
	this.setValues();
}

CiteInput.prototype.setStatus = function(txt,hov,tip,func)
{
	if (txt.length) {
		if (this.ss != null && this.ss != undefined) {
			this.ss.remove();
		}
		this.status_cb = func;
		this.ss = new StatSpan(this.status_td,txt,hov,createMethodReference(this,'statusDel'));
		if (tip != undefined) {
			this.ss.setTip(tip);
		}
		$(this.status_td).show();
	} else if (this.ss != null && this.ss != undefined) {
		this.ss.remove();
		this.status_cb = undefined;
		$(this.status_td).hide();
	}
}

CiteInput.prototype.statusDel = function(e)
{
	this.ss = null;
	if (this.status_cb != undefined) {
		this.status_cb();
	}
}

CiteInput.prototype.setLengthWeight = function (select_array) {
	this.type ="length_measure";
	this.setSelect(select_array);
}


CiteInput.prototype.getFields= function () {
	if (this.type == "length_measure") {
		return [ this.field_name, "a", "b" ];
	} else {
		return [ this.field_name ];
	}
}
CiteInput.prototype.getValues = function () {
	if (this.type == "length_measure") {
		return [ this.element.value, this.a.value, this.b.value ];
	} else {
		return [ this.element.value ];
	}
}

CiteInput.prototype.setValues = function () {
	var ns = Array();
	var val = "";
	if( this.parent instanceof StageTab  && this.parent.stage["stage_" + this.field_name] != undefined)	{
		ns = this.parent.stage["stage_" + this.field_name];
	} else if ( this.parent instanceof NodeDialog && this.parent.node["node_" + this.field_name] != undefined ) {
		ns = this.parent.node["node_" + this.field_name];
	} 
	if (ns.length < 1)
		$(this.citedvars).html(" &nbsp; ");
	else 
		$(this.citedvars).html("");

	for (var i=0; i< ns.length; i++ ) {
		var tmp = ns[i];
		var val = tmp[this.field_name]; 
		var citespan = new CiteSpan( this, tmp, val);
	}
}

CiteInput.prototype.addNewCitedVarCB = function ( data ) {
	if (data.error != undefined) {
		alert(data.error);
		return;
	}
	if( this.parent instanceof StageTab )	{
		if (data["stage_" + this.field_name] !=  undefined) { 
			this.parent.stage["stage_" + this.field_name] =  data["stage_" + this.field_name];
		}
	} else if ( this.parent instanceof NodeDialog ) {
		if (data["node_" + this.field_name] !=  undefined) { 
			this.parent.node["node_" + this.field_name] =  data["node_" + this.field_name];
		}
	}
	citevardialog.close();
	this.clear();	
	this.setValues();
}

CiteInput.prototype.addNewCitedVar = function ( cite_id ) {
	if (this.element.value != "" ) {
		var p = new Object();
		p.functionName = "addNewCitedVar";
		if( this.parent instanceof StageTab )	{
			p.stage_id = this.parent.stage.id;
			p.table = "stage_" + this.field_name;
		} else if ( this.parent instanceof NodeDialog ) {
			p.node_id = this.parent.node.id;
			p.table = "node_" + this.field_name;
		}
		p.cite_id = cite_id;
		p.fields = this.getFields();
		p.values = this.getValues();
		var comment = this.comment.getComment();
		if ( comment != undefined && $.trim(comment) != "" ) {
			p.comment = comment;
		}
		var datum = this.datum.getDatum();
		if (datum!= undefined) {
			p.datum = JSON.stringify( datum );
		}
		$.ajax( { async:true, type:"POST", dataType:"json", 
			data: p,
			url: "query.php",
			error : function (data, t, errorThrown) { alert("error (" + t + "):" + errorThrown); },
			success: createMethodReference(this, "addNewCitedVarCB")
		});
	}
}

CiteInput.prototype.setOnPressEnterEvent = function ( callback ) {
	$(this.element).keypress(function(event) {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if(keycode == 13) {
			callback(event);
		}
	});
}

function StatSpan(e,text,hov,del)
{
	this.text = text;
	this.deleteCallback = del;
	this.parent = e;
	this.span = document.createElement('span');
	do {
		this.id = $(e).attr('id')+Math.floor(Math.random()*1000);
	} while ($("#"+this.id).length > 0);

	var $sp = $(this.span);
	$sp.css('margin','2px');
	$sp.css('display','inline-block');
	$sp.attr('id',this.id);
	$sp.addClass('cited');
	$sp.css('background','#ffffcc');
	$sp.append(text+'&nbsp;');

	this.delete_button = document.createElement('button');
	var $but = $(this.delete_button);
	$but.attr('data-icon','delete');
	$but.text(hov);
	$sp.append($but);
	$but.button( { icons: {primary:'ui-icon-circle-close'}, text: false } );
	$but.click(  createMethodReference(this, "deleteClicked") );
	$but.css( "border", "0px" );
	$but.css( "height", "10px" );
	$but.css( "width", "10px" );
	$but.css( "padding", "0px" );
	$but.css( "display", "inline-block" );
	
	$sp.appendTo($(e));
}

StatSpan.prototype.setTip = function(txt)
{
	$(this.span).attr('title',txt);
	$(this.span).tipTip();
}

StatSpan.prototype.remove = function(call)
{
	$(this.span).remove();
	if ((call == undefined || call == true) && this.deleteCallback != undefined) {
		this.deleteCallback(undefined);
	}
	this.span = undefined;
}

StatSpan.prototype.deleteClicked = function(e)
{
	$(this.span).remove();
	if (this.deleteCallback != undefined) {
		this.deleteCallback(e);
	}
}

function CiteSpan (citeinput, val_obj, val) {
	this.citeinput = citeinput;
	this.val_obj = val_obj; // this contains the cite_id, datum, and comment
	this.value = val.replace(/ /g, "&nbsp;") 

	this.span = document.createElement("span");
	this.span.style.margin = "2px";
	this.span.style.display = "inline-block";
	this.id = this.citeinput.id + "_cite_" + this.val_obj.cite_id;
	$(this.span).html( val.replace(/ /g, "&nbsp;") );
	this.span.id = this.id;
	this.span.className = "cited";
	this.citeinput.citedvars.appendChild(this.span);

	this.getCitationInfo(this.val_obj.cite_id);

}

CiteSpan.prototype.getCitationInfoCB = function(data, t, x) {	
	if (data == null) {
		alert("Error : data is null" );
	} else if (data.error != undefined ) {
		alert("Error: " + data.error);
	} else {
		// add to global citations array
		citations.push(data);
		citevardialog.addCiteToCitationDialogSelect(data);
		this.cite = data;
		var tmp = this.value + '&nbsp;-&nbsp;[' + data.authors[0].last_name + '.' + data.year +']';
		tmp +=  '&nbsp;&nbsp;';
		this.delete_button = document.createElement("button");
		this.delete_button.setAttribute("data-icon", "delete");
		$(this.delete_button).text("delete");
		$( this.span ).html( tmp  );
		this.span.appendChild( this.delete_button );

		var $but = $( this.delete_button);
		$but.button( { icons: {primary:'ui-icon-circle-close'}, text: false } );
		$but.click(  createMethodReference(this, "deleteCitedVar") );
		$but.css( "border", "0px" );
		$but.css( "height", "10px" );
		$but.css( "width", "10px" );
		$but.css( "padding", "0px" );
		$but.css( "display", "inline-block" );
		//$but.css( "float", "none" );
		//$but.css( "clear", "both" );

		var authors="";
		for (var j=0;j< this.cite.authors.length;j++) {
			if (j != 0) authors+=", ";
			authors+=this.cite.authors[j].first_name + " ";
			authors+=this.cite.authors[j].last_name;
		}
		var tooltip = authors + ' - \'' +  this.cite.title + '\',' +  this.cite.year;
		tooltip += '<br><b>' + this.citeinput.display_name + '</b> '+ this.value;
		if (this.val_obj.a != undefined && this.val_obj.b != undefined)
			tooltip += ', <b>A:</b> ' + this.val_obj.a + '  <b>B:</b> '+ this.val_obj.b;
		if (this.val_obj.comment != undefined && this.val_obj.comment != null && this.val_obj.comment != "")
			tooltip += '<br>comment: ' + this.val_obj.comment;
		if (this.val_obj.datum != undefined && this.val_obj.datum != null && this.val_obj.datum != "" )
			tooltip += '<br>date: ' + this.val_obj.datum;  // datum is already in json string form here.
		this.span.setAttribute('title', tooltip);
		$( this.span ).tipTip();
	}
}

// call the DB to get citation info for a particular id
// appends the returned data to the global citation array
CiteSpan.prototype.getCitationInfo = function ( cite_id ) {
	// first check to see if we have it globally already
	var tmp_cite = citations.get(cite_id)
	if ( tmp_cite != undefined ) {
		return tmp_cite;
	}
	var postdata = Object() ;
	postdata.functionName = "getCitationInfo";
	postdata.cite_id = cite_id;
	$.ajax( { async:true, type:"GET", dataType:"json",
			data: postdata, 
			url: "query.php", 
			error : function (data, t, errorThrown) { alert("error (" + t + "):" + errorThrown); },
			success: createMethodReference(this, "getCitationInfoCB") 
	});
	return postdata.response;
}

// delete any cited variable whether for stage or node
// table - full name of table (node_max_age, stage_residency, etc.)
CiteSpan.prototype.deleteCitedVar = function( ) {
	if (!confirm("Delete this cited variable for '" + this.citeinput.display_name  + "'?" ) ) {
		return;
	}
	var obj = Object();
	obj.functionName = "deleteCitedVar";
	if( this.citeinput.parent instanceof StageTab )	{
		obj.stage_id = this.citeinput.parent.stage.id;
		obj.table = "stage_" + this.citeinput.field_name;
	} else if ( this.citeinput.parent instanceof NodeDialog ) {
		obj.node_id = this.citeinput.parent.node.id;
		obj.table = "node_" + this.citeinput.field_name;
	}
	obj.cite_id = this.val_obj.cite_id;
	$.ajax( { async:true, type:"POST", dataType:"json",
		data: obj,
		url: "query.php",
		error : function (data, t, errorThrown) { alert("error (" + t + "):" + errorThrown); },
		success: createMethodReference(this, "deleteCitedVarCB")	
	} );
}

CiteSpan.prototype.deleteCitedVarCB = function( data, t, x) {
	if (data == null || data == undefined) {
		alert("Error : data is null" );
	} else if (  data.error != undefined) {
		alert("Error deleting citation value: " + data.error );
	} else {
		// everything went okay, we want to remove that one
		var pa = $( this.span ).parent();
		$( this.span ).remove();
		// this keeps the spacing together in the floated divs
		if ( $(pa).html( ) == "") 
			$(pa).html("&nbsp;");
		this.citeinput = undefined;
		this.cite = undefined;
		this.span = undefined;
		this.value = undefined;
	}
}
