// <![CDATA[

function in_array(needle,haystack) {
	var bool = false;
	for (var i=0; i<haystack.length; i++) {
		if (haystack[i]==needle) {
			bool=true;
		}
	}
	return bool;
}


// this is needed by selector and region selector to get events 
function createMethodReference(object, methodName) {
	return function (event) {
		object[methodName].call(object, event || window.event);
	};
}

// clean up an XML/HTML node by removing all its children nodes
function removeAllChildren(element)
{
        while(element.hasChildNodes())
          element.removeChild(element.firstChild);
}


function  pointerX (event) {
	return event.pageX || (event.clientX + 
		(document.documentElement.scrollLeft || document.body.scrollLeft));
}

function pointerY (event) {
	return event.pageY || (event.clientY +
		(document.documentElement.scrollTop || document.body.scrollTop));
}


function printXML( node ) {
	var xml = "";
	
	if (node != null ) { 
		xml = "<" + node.tagName ;
	       	var at = node.attributes;
		if (at) {
			for (var i=0;i<at.length; i++) {
				xml += " " + at[i].name + "=\"" + at[i].value + "\"";
			}
		}
		 if( node.hasChildNodes ) {
			xml += ">\t";
       		       	for(var m = node.firstChild; m != null; m = m.nextSibling) {
				xml += printXML(m); //m.nodeName +  ";   " ;
			}
			xml += "</" + node.tagName + ">\n";
		} else if ( node.value ) {
			xml += " value=\"" + node.value + "\"/>\n";
		} else if (node.text ) {
			xml += ">"+ node.text + "</" + node.tagName + ">\n";
		} else {
			xml += " />\n";
		}
	}
	return xml;
}

// threadsafe asynchronous XMLHTTPRequest code
function makeRequest ( url, callback, callbackdata, method, postdata ){
	// we use a javascript feature here called "inner functions"
	// using these means the local variables retain their values after the outer function
	// has returned. this is useful for thread safety, so
	// reassigning the onreadystatechange function doesn't stomp over earlier requests.
	
	function bindCallback(){
		if (ajaxRequest.readyState == 0) {
			// uninitialized
		} 
		if (ajaxRequest.readyState == 1) {
			// loading
		} 
		if (ajaxRequest.readyState == 2) {
			// loaded
		} 
		if (ajaxRequest.readyState == 3) {
			// interactive
		} 
		if (ajaxRequest.readyState == 4) {
			if (ajaxRequest.status == 200) {
				if (ajaxCallback){
					ajaxCallback( ajaxCallbackData, ajaxRequest.responseText);
				} 
				//else {
				//	alert('no callback defined');
				//}
			} else {
				alert("There was a problem retrieving the xml data:\n" + 
					ajaxRequest.status + ":\t" + ajaxRequest.statusText + "\n" + 
					ajaxRequest.responseText);
			}
		}
	}
	
	// use a local variable to hold our request and callback until the inner function is called...
	var ajaxRequest = null;
	var ajaxCallbackData = callbackdata;
	var ajaxCallback = callback;

	// bind our callback then hit the server...
	if (window.XMLHttpRequest) {
		// moz et al
		ajaxRequest = new XMLHttpRequest();
		ajaxRequest.onreadystatechange = bindCallback;
		if ( method == "get" ) {
			ajaxRequest.open("GET", url , true);
			ajaxRequest.send(null);
		} else {
			ajaxRequest.open("POST", url , true);
			//ajaxRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8");
			ajaxRequest.send( postdata );
		}
	} 
}

// ]]>

