/* 
 * system.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2007 EPiServer AB
*/


var _refreshPart=null;

function RefreshBodyPart(refreshPart,loadFromUrl,postName,postValue)
{		
	var frame = document.frames['__epLoaderFrame'];

	if(frame==null)
	{
		frame		= document.createElement("IFRAME");
		frame.id	= '__epLoaderFrame';
		frame.name	= '__epLoaderFrame';
		frame.attachEvent("onload",RefreshBodyPartOnLoad);
		frame.style.display = 'none';
		document.body.appendChild(frame);
	}
	_refreshPart		= refreshPart;
	
	if(loadFromUrl==null)
		loadFromUrl = document.location.href;
	
	if(postName!=null && postValue!=null)
	{
		if(frame.document.body!=null)
			frame.document.body.innerHTML = "";
		else
			frame.document.write('<HTML><BODY></BODY></HTML>');
			
		var form = document.createElement('<form name="form" method="post" action="' + loadFromUrl + '"></form>');
		var input = document.createElement('<input type="hidden" name="' + postName + '" value="">');
		form.appendChild(input);
		frame.document.body.innerHTML = form.outerHTML;
		if(postValue.value)
			frame.document.form.elements[postName].value = postValue.value;
		else
			frame.document.form.elements[postName].value = postValue;
		frame.document.form.submit();
	}
	else
		frame.document.location.href = loadFromUrl;
}

function RefreshBodyPartOnLoad()
{
	var frame	= document.frames['__epLoaderFrame'];
	var source	= this.document.all[_refreshPart];
	var target	= frame.document.all[_refreshPart];
		
	if(source!=null && target!=null)
	{
		source.insertAdjacentElement('beforeBegin',target);
		source.parentElement.removeChild(source);
	}
}

function DeleteRow( oRow )
{
	oRow.parentElement.deleteRow(oRow.rowIndex);
	return false;
}

//Used by membershipbrowser.aspx, moves users/roles between drop downs.
function SecMoveOption( oSelectFrom, oSelectTo )
{
	while (oSelectFrom.selectedIndex >= 0)
    {
        var nIndex = oSelectFrom.selectedIndex;
        var newOption = new Option(oSelectFrom.options[nIndex].text,oSelectFrom.options[nIndex].value);
		//TODO: Find a way to make this firefox/ie friendly.
		try
		{
		    // IE way
		    oSelectTo.add(newOption);
		}
		catch(ex)
		{
		    // DOM level 2
		    oSelectTo.add(newOption,null);
		}
		oSelectFrom.remove(nIndex);
	}
}

function ShowPopupBlockedInfo()
{
	alert(EPi.Translate("/javascript/system/popupsblocked"));
}

//***********************************************************************************************************


function OpenDialogMembershipDeleteUserOrRole( rolerOrUserName, securityEntity, callbackMethod, callbackMethodArguments, dialogArguments )
{
	var url = EPi.ResolveUrlFromUI('admin/DeleteMembershipDialog.aspx') + '?NameRoleOrUser=' + rolerOrUserName + '&SecurityEntity=' + securityEntity;
	var dialogHeight = 300;
	var dialogWidth = 550;

	try
	{
		EPi.CreateDialog(url, callbackMethod, callbackMethodArguments, dialogArguments, {width: dialogWidth, height: dialogHeight});
	}
	catch (ex)
	{
		ShowPopupBlockedInfo();
	}

	return false;
}

//Callback functions for Dialog
function MembershipDeleteCompleted(returnValue, callbackArguments)
{    
    if(returnValue)
    {
       reloadPage();
    }
}


//***********************************************************************************************************
function OpenDialogUserAndGroupBrowser( securityType, search, editDir, allowMultiple, callbackMethod, callbackMethodArguments, dialogArguments )
{
	var search = (search == '' ? '' : '&search=' + encodeURIComponent(search));
	var url = editDir + '/MembershipBrowser.aspx?type=' + securityType + search + '&AllowMultiple=' + allowMultiple;
	var dialogHeight = 580;
	var dialogWidth = 550;

	try
	{
		EPi.CreateDialog(url, callbackMethod, callbackMethodArguments, dialogArguments, {width: dialogWidth, height: dialogHeight});
	}
	catch (ex)
	{
		ShowPopupBlockedInfo();
	}

	return false;
}

//Callback functions for Dialog
function BrowserDialogCompleted(returnValue, callbackArguments)
{

    var arrayReturnObjects;
    if(!returnValue)
    {
        return;
    }
    for(var i=0; i < returnValue.length; i++)
    {
        arrayReturnObjects =  returnValue[i].split(";");
        addRows(arrayReturnObjects[0], arrayReturnObjects[1]);
    } 
}

//Callback functions for Dialog
function BrowserPermissionDialogCompleted(returnValue, callbackArguments)
{
    var arrayReturnObjects;
    if(!returnValue)
    {
        return;
    }
    for(var i=0; i < returnValue.length; i++)
    {
        arrayReturnObjects =  returnValue[i].split(";");
        addPermissionRows(arrayReturnObjects[0], arrayReturnObjects[1]);
    } 
}


//***********************************************************************************************************

function ToggleElementsInContainer(container,source)
{
	var form = getForm();
	for(var i=0;i<form.elements.length;i++)
	{
		if(IsElementInContainer(container,form.elements[i]) && form.elements[i]!=source)
			form.elements[i].disabled = !(form.elements[i].disabled);
	}
	
}

function IsElementInContainer(container,element)
{
	var tag = element;
	while(tag=tag.parentElement)
	{
		if(tag==container)
			return true;
	}
	
	return false;
}
//***********************************************************************************************************


function SimulateFormField(name,value)
{
	var form = getForm();
	
	if(!form.elements[name])
	{
		var input = document.createElement('input');
		input.type = 'hidden';
		input.name = name;
		input.id = name;
		input.value = value;
		form.appendChild(input);
	}
}

function getForm()
{
	if(window.event==null)
		return document.forms[0];
	
	var form = findParentForm(window.event.srcElement);	
	
	if(!form && document.forms.length>0)
	{
		form=document.forms[0];
	}
		
	return form;
}

function findParentForm(obj)
{
	var tag = obj;
	while(tag=tag.parentElement)
	{
		if(tag.tagName.toLowerCase()=='form')
			return tag;
	}
	
	return null;
}

var EPi;

if (!EPi) 
{
    EPi = {};
}

EPi.GetOffset = function(node)
{
    var offsetLeft = 0;
    var offsetTop = 0;
    
    if (node.offsetParent)
    {
        // In IE6 We have to check if node is body.
        while (node.offsetParent && node.tagName.toLowerCase() != "body")
        {
            offsetLeft += node.offsetLeft;
            offsetTop += node.offsetTop;
            node = node.offsetParent;
        }
    }
    var returnValue = [offsetLeft, offsetTop];
    return returnValue;
}



// Form managing support used to get a consistent posting behaviour when using different kind of buttons
EPi.Form = {};

EPi.Form._isRegistered = false;

// Sets the onsubmit of the ASP.NET form to our own submit handler EPi.Form_OnSubmit.
// If any onsubmit exists its converted to use DOM Level 2 Events.
EPi.Form.SetOnSubmit = function()
{
    EPi.Form._isRegistered = true;
    var formNode = EPi.GetForm();
    if (formNode.onsubmit)
    {
        EPi.Form.RegisterSubmitHandler(formNode.onsubmit);
    }
    formNode.onsubmit = EPi.Form._OnSubmit;
}

// Our own submit handler
EPi.Form._OnSubmit = function(e)
{
    // If IE we have to check for the event in window.event
    if (!e)
    {
        e = window.event;
    }
   
    // If we have e it's a native post which automatically will trigger the submit event.
    if (e && e.type == "submit" && !document.addEventListener)
    {
        return;
    }
    
    var eventType = "submit";
    if (document.addEventListener)
    {
        // In EPi.AddEventListener we add the custom episubmit event type if the browser uses addEventListener.
        // Since dispatchEvent of submit in non IE also submits(!) we have to dispatch our own event.
        // Hence we change event type to episubmit.
        eventType = "episubmit";
        
    }
    
    // Dispatch a submit event to trigger listeners of submit event
    return EPi.DispatchEvent(EPi.GetForm(), eventType);
   
}

// Converts eventhandlers added to the onsubmit attribute of the ASP.NET form
// to use DOM Level 2 Event model.
// In event model 1 the eventHandler should return false to prevent the event
// In event model 2 we use preventDefault on the event.
EPi.Form.RegisterSubmitHandler = function(func)
{
    var eventHandler= function(e) 
	{
	    if (func() == false)
	    {
	        e.preventDefault();
	    }
	}
	EPi.AddEventListener(EPi.GetForm(), "submit", eventHandler);
}

// DEPRECATED:  Use EPi.AddEventListener(EPi.GetForm(), "submit", eventHandler);
//              Use e.preventDefault(); to prevent submit in eventHandler
// Register your script application to EPiServer's submit-function queue. 
// The 'func' argument is a function object that will be called before the page is submitted.
function RegisterSubmitHandler(func)
{
	EPi.Form.RegisterSubmitHandler(func);
}


// Used in TabStrip.
EPi.Tab = {};
EPi.Tab.Click = function(oTab, oBody, oInput, oActiveTab) 
{
    if (oActiveTab) 
    {
		oActiveTab.Close();
	}
	oActiveTab.oTab = oTab.id;
	oActiveTab.oBody = oBody;
	oActiveTab.oInput = oInput;
	oActiveTab.Open();
}

EPi.Tab.Control = function(oTab, oBody, oInput)
{
    this.oTab	= oTab;
	this.oBody	= oBody;
	this.oInput	= oInput;
	this.Close = function()
	{
		if(typeof(this.oBody)=='string' && document.getElementById(this.oBody))
		{
			document.getElementById(this.oBody).className = "epitabobjectinactive";
		}
		
		EPi.Tab.SwitchTabClass(document.getElementById(this.oTab), false);
		document.getElementById(this.oInput).value='';
	}
	this.Open = function()
	{
		if(typeof(this.oBody)=='string' && document.getElementById(this.oBody))
		{
			document.getElementById(this.oBody).className = "epitabobjectactive";
		}
		
		EPi.Tab.SwitchTabClass(document.getElementById(this.oTab), true);
		document.getElementById(this.oInput).value='TabClicked';
	}
}

EPi.Tab.SwitchTabClass = function(oTab, active)
{
	var tabElementsArray = oTab.childNodes;
	
	for(var i = 0; i < tabElementsArray.length; i++)
	{
		if(active)
		{
			switch(tabElementsArray[i].className)
			{
				case 'epitabinactiveleft':
					tabElementsArray[i].className = 'epitabactiveleft';
					break;
				case 'epitabinactiveright':
					tabElementsArray[i].className = 'epitabactiveright';
					break;
				case 'epitabinactive':
					tabElementsArray[i].className = 'epitabactive';
					break;
				default:
				    break;
			}
		}
		else
		{
			switch(tabElementsArray[i].className)
			{
				case 'epitabactiveleft':
					tabElementsArray[i].className = 'epitabinactiveleft';
					break;
				case 'epitabactiveright':
					tabElementsArray[i].className = 'epitabinactiveright';
					break;
				case 'epitabactive':
					tabElementsArray[i].className = 'epitabinactive';
					break;
			}
		}
	}
}

// ResizeWindow event. Used by serverside ResizeWindowEvent to resize elements when
// the window containing the elements loads or resizes.
EPi.ResizeWindow = function(e) 
{
    EPi.RemoveEventListener(window, "load", EPi.ResizeWindow);
    EPi.ResizeWindow._resize(e);
    EPi.AddEventListener(window, "resize", EPi.ResizeWindow._resize);
}

EPi.ResizeWindow.ElementsArray = new Array();

EPi.ResizeWindow.Add = function(id)
{
    var resizeArray = EPi.ResizeWindow.ElementsArray;
    var alreadyExists = false;
    
    for (var i=0; i < resizeArray.length; i++)
    {
        if (id == resizeArray[i])
        {
            alreadyExists = true;
            break;
        }
    }
    
    if (!alreadyExists)
    {
       EPi.ResizeWindow.ElementsArray.push(id);
       EPi.ResizeWindow._resize();
       EPi.AddEventListener(window, "resize", EPi.ResizeWindow._resize);
    }
}

EPi.ResizeWindow._resize = function(e)
{
    if (EPi.ResizeWindow.ElementsArray.length == 0)
    {
        return;
    }
    
    var i, node;
    var currentDisplayStyle = new Array();
    var len = EPi.ResizeWindow.ElementsArray.length;
    var formNode = EPi.GetForm();
    
    for (i=0; i < len; i++)
    {
        node = document.getElementById(EPi.ResizeWindow.ElementsArray[i]);
        if (node == null) 
        {
            return;
        }
        currentDisplayStyle[i] = EPi.GetCurrentStyle(node, "display");
        node.style.display = "none";
    }
    
    for (i=0; i < len; i++)
    {
        node = document.getElementById(EPi.ResizeWindow.ElementsArray[i]);
        node.style.height = Math.max((document.documentElement.clientHeight - formNode.offsetHeight - 12), 0) + "px";
    }
    
    for (i=0; i < len; i++)
    {
        node = document.getElementById(EPi.ResizeWindow.ElementsArray[i]);
        if (currentDisplayStyle[i] == "none" || currentDisplayStyle[i] == "inline") 
        {
            currentDisplayStyle[i] = "block";
        }
        node.style.display = currentDisplayStyle[i];
    }
}

// Scripts for EPiServerUI.ToolButton
EPi.ToolButton = {};
EPi.ToolButton.SetEnabled = function(button, enable)
{
    var buttonNode = EPi._GetDomObject(button);
    if (typeof(buttonNode) != "object") {
        return;
    }
    var parentNode = buttonNode.parentNode;
   
    if (enable)
    {
        // Enable
        var className = parentNode.className.replace(/disabled/, "");
        if (parentNode.className != className) //Prevent flashing buttons in IE
        {
            parentNode.className = className;
        }
        buttonNode.removeAttribute("disabled");
    }
    else
    {
        // Disable
        // Check if button already is disabled
        if (!buttonNode.disabled) 
        {
            buttonNode.setAttribute("disabled", "disabled");
            var className = parentNode.className.replace(/disabled/, "");
            parentNode.className += "disabled";
        }
    }
}

EPi.ToolButton.MouseDownHandler = function(node)
{
   node.parentNode.className += " epitoolbuttonmousedown";
}

EPi.ToolButton.ResetMouseDownHandler = function(node)
{
    var className = node.parentNode.className.replace(/ epitoolbuttonmousedown/, "");
    node.parentNode.className = className;
}


EPi.GetDialog = function()
{
    if (window.opener && window.opener.EPiOpenedDialog)
    {
        return window.opener.EPiOpenedDialog;
    }
    else if (window.top.EPiOpenedDialog)
    {
        return window.top.EPiOpenedDialog;
    }
}

EPi.CreateDialog = function(url, callbackMethod, callbackArguments, dialogArguments, features)
{
    var dialog = new EPi.Dialog(callbackMethod, callbackArguments, dialogArguments)
    dialog.Initialize(url, features);
    
    return dialog;
}

// Creates a new epidialog object for PageBrowser.
EPi.CreatePageBrowserDialog = function(url, id, disableCurrentPageOption, displayWarning, info, value, language, callbackMethod, callbackArguments)
{
    var completeUrl = url + '?id=' + id + '&disablecurrentpageoption=' + disableCurrentPageOption +'&info=' + info + '&value=' + value + '&epslanguage=' + language + '&displaywarning=' + displayWarning;
    if (!callbackMethod) 
    {
        callbackMethod = function(returnValue) 
        			{
                        if (returnValue)
                        {
                            if (document.getElementById(info).onchange)
                            {
                                //theForm.submit();
                            }
                            else
                            {
                                EPi.PageLeaveCheck.SetPageChanged(true);
                            }
                        }
                    }
    }
    if (!callbackArguments)
    {
        callbackArguments = null;
    }
    var dialogArguments = window.document;
    var features = {width:380, height:550};
    return EPi.CreateDialog(completeUrl, callbackMethod, callbackArguments, dialogArguments, features);
}

// Creates a new epidialog object for PageBrowser.
EPi.CreateDateBrowserDialog = function(url, id, callbackMethod) {
    if (!url) {
        url = EPi.ResolveUrlFromUtil("DateBrowser.aspx");
    }
    url += "?value=" + document.getElementById(id).value;

    if (!callbackMethod) {
        callbackMethod = function(returnValue, id) {
            if (typeof(returnValue) != "undefined") {
                var node = document.getElementById(id);
                node.value = returnValue;
                EPi.DispatchEvent(node, "change");
            }
        }
    }

    var features = { width: 240, height: 300, scrollbars: "no" };

    return EPi.CreateDialog(url, callbackMethod, id, null, features);
}



//******************************************************************************************
// EPiDialog class. Used to popup a dialog window which communicates from the opening window.
//******************************************************************************************
// -- url                   Path to the file to open in a dialog, required.
// -- callbackMethod        Method to call when closing the dialog, optional.
// -- callbackArguments     Variant that specifies the arguments to use in the callbackMethod method, when returning/closing the dialog.
// -- dialogArguments       Variant that specifies the arguments to use when displaying the document. Use this parameter to pass a value of any type, including an array of values. 
//                          The dialog loaded can extract the values passed by the caller from the dialogArguments property of the EPiDialog object.
// -- features              Optional. Object that specifies the dialog position and size.
//                          Example: {width:300, height:200}
//                          The following values are valid by default:width:intWidth|sWidth, height:intHeight|sHeight, left: intLeft|sLeft, top: intTop|sTop, scrollbars: "yes"|"no", resizable:"yes"|"no"
//                          Default is width:510, height:500, resizable:"yes", scrollbars:"yes". Position is centered in opening window.

EPi.Dialog = function(callbackMethod, callbackArguments, dialogArguments)
{
    this.callbackMethod = callbackMethod || null;
    this.callbackArguments = callbackArguments || null;
    this.dialogArguments = dialogArguments || null;
    this._opener = window.top;
    this._opener.EPiOpenedDialog = this;
}

// CreateCover is used to create a cover frame in the window opening the dialog if it's not already created.
// The editor creates this cover when initializing the editor to prevent corrupting the MSHTML undo stack (which is courrupted by document.appendChild).
EPi.Dialog.CreateCover = function()
{
    var win = window.top;
    if (!win.epiDialogCover)
    {
        var coverFrame = win.epiDialogCover = win.document.createElement("iframe");  
        // We might get a popup question about non-secure items if using https and the iframes location is not secure.
        //coverFrame.src = EPi.ResolveUrlFromUtil("Empty.htm");
        
        with (coverFrame.style)
        {
            position = "absolute";
            top = 0;
            left = 0;
            width = "100%";
            height = "100%";
            overflow = "hidden";
            border = 0;
            backgroundColor = "#101010";
            zIndex = 10000;
            display = "none";
            opacity = 0.01;
            filter = "alpha(opacity=1)";
        }
        
        EPi.AddEventListener(coverFrame, "load", function(e) {
                                                  EPi.AddEventListener(this.contentWindow.document, "click", EPi.Dialog._SetFocusToOpenedDialog);   
                                                 });
        
        win.document.body.appendChild(coverFrame); 
    }
}

EPi.Dialog._SetFocusToOpenedDialog = function(e)
{
    if (window.top.EPiOpenedDialog)
    {
        window.top.EPiOpenedDialog._SetFocus();
    }
}

var _p = EPi.Dialog.prototype;
_p.callbackMethod = null;
_p._dialog = null;
_p._opener = null;

// Close the dialog and call the callbackMethod function.
// The callbackMethod is called with arguments (returnValue, callbackArguments);
_p.Close = function(returnValue)
{
    this._CleanUpAndReturn(returnValue);
}

_p.Initialize = function(url, features)
{
    this._SetDialogFeatures(features);
    
    var opener = this._opener;
    
    try
	{
	    this._dialog = opener.open(url, "", "menubar=no,location=no,resizable=" + this.resizable + ",scrollbars=" + this.scrollbars + ",status=no, width=" + parseInt(this.width) + ", height=" + parseInt(this.height) + ", top=" + parseInt(this.top) + ", left=" + parseInt(this.left));	
	}
	catch (ex)
	{
	    ShowPopupBlockedInfo();
		this._CleanEvents();
        this._CleanElements();
		this.Close(null);
	    return;
	}
	
	// Create or use an existing dialog cover
	if (opener.epiDialogCover == null)
    {
        EPi.Dialog.CreateCover();
    }

    opener.epiDialogCover.style.display = "block";
    this._AddEvents();
}

_p._SetDialogFeatures = function(features)
{
    var opener = window.top;

    if (typeof(features) == "object")
    {
        for (var p in features)
        {
            this[p.toLowerCase()] = features[p];
        }
    }
    
    if (!this.resizable) {this.resizable = "yes"};
    if (!this.scrollbars) {this.scrollbars = "yes"};
    if (!this.width) {this.width = 510;}
    if (!this.height) {this.height = 500;}
    
    // Make sure the dialog size isn't larger than screen real estate.
    if (this.width > window.screen.availWidth-50)
    {
        // Don't want to take up the entire width.
        this.width = window.screen.availWidth-50;
        this.left = 20;
    }
    
    if (this.height > window.screen.availHeight-100)
    {
        //Subtract som height for title bar, address bar and status bar.
        this.height = window.screen.availHeight-100;
        this.top = 20;
    }
    
    if (!this.left)
    {
        if (opener.innerWidth)
        {
            this.left = opener.screenX + opener.innerWidth/2 - this.width/2;
        }
        else
        {
            this.left = opener.screenLeft + opener.document.body.offsetWidth/2 - this.width/2;
        }
    }
    
    if (!this.top)
    {
        if (opener.innerHeight)
        {
            this.top = opener.screenY + opener.innerHeight/2 - this.height/2;
        }
        else
        {
            this.top = opener.screenTop + opener.document.body.offsetHeight/2 - this.height/2;
        }
        var left = Math.max(0, this.left);
        var top = Math.max(0, this.top);
        
        this.left = left;
        this.top = top;
    }
}

_p._DialogUnload = function(e)
{
    var dialogWindow = this;
    var epiDialog = this.opener.EPiOpenedDialog;
    
    EPi.RemoveEventListener(this, "unload", epiDialog._DialogUnload);
    
    function TimeoutCheck()
    {
        if (epiDialog._dialog)
        {
            var dialogClosed = dialogWindow.closed;
            // Is the dialog window already closed.
            if (dialogClosed)
            {
                epiDialog._CleanUpAndReturn(null);
            }
            else
            {
                epiDialog._AddUnLoadEventListener();
            }
        }
    }
    
    this.opener.setTimeout(TimeoutCheck, 1);    
}

_p._AddUnLoadEventListener = function()
{
    EPi.AddEventListener(this._dialog, "unload", this._DialogUnload);
}

_p._CleanUpAndReturn = function(returnValue) {
    var message;
    // If we have a _dialog this dialog object has opened a window and we have to clean things up.
    if (this._dialog != null) {
        // We need to override default EPi.PageleaveCheck handling and do the check ourselves.
        // The proper way would be to call _CleanUpAndReturn in unload handler(by this._dialog.close())
        // which would make default PageLeaveCheck handling work but then we will loose returnValue reference in IE6
        // which makes the dialogs useless.
        if (!this._dialog.closed && this._dialog.EPi && this._dialog.EPi.PageLeaveCheck && this._dialog.EPi.PageLeaveCheck.trigger == null && this._dialog.EPi.PageLeaveCheck.HasPageChanged()) {

            if (this._dialog.EPiObject && this._dialog.EPiObject.pageLeaveMessage) {
                message = this._dialog.EPiObject.pageLeaveMessage;
            }
            else {
                message = EPi.Translate("/system/editutil/leavepagewarning");
            }
            var confirmClose = this._dialog.confirm(message);
            if (!confirmClose) {
                // Cancel closing dialog
                return;
            }
            else {
                // Prevent default pageLeaveCheck confirm dialog from appearing
                this._dialog.EPi.PageLeaveCheck.enabled = false;
            }
        }

        // If the opened window is still open close it.
        if (!this._dialog.closed) {
            EPi.RemoveEventListener(this._dialog, "unload", this._DialogUnload);
            this._dialog.close();
        }
        // Clean up of this dialog
        this._CleanEvents();
        this._CleanElements();
    }

    this._CleanDialog();

    window.top.EPiOpenedDialog = null;
    this._opener.EPiOpenedDialog = null;
    delete this._opener;

    // When the dialog is closing call the callbackMethod function (if specified) to do whatever it is supposed to with the result of the dialog.
    if (typeof (this.callbackMethod) == "function") {
        this.callbackMethod(returnValue, this.callbackArguments);
    }

    this.callbackMethod = null;
    this.callbackArguments = null;

    delete this.callbackMethod;
    delete this.callbackArguments;
}

_p._AddEvents = function()
{
    EPi.AddEventListener(window.top, "unload", this._OnOpenerUnload);
    EPi.AddEventListener(window.top, "focus", this._SetFocus);

    this._AddUnLoadEventListener();
}

// Clean up attached events
_p._CleanEvents = function()
{
    EPi.RemoveEventListener(window.top, "unload", this._OnOpenerUnload);
    EPi.RemoveEventListener(window.top, "focus", this._SetFocus);
}

_p._OnOpenerUnload = function()
{
    if (this.EPiOpenedDialog)
    {
        this.EPiOpenedDialog._CleanUpAndReturn(null);
    }
}

_p._SetFocus = function(e)
{
    if (window.top.EPiOpenedDialog && window.top.EPiOpenedDialog._dialog) // If not found the dialog is in closing state.
    {
        
        if (window.top.EPiOpenedDialog._dialog.closed)
        {
            // In some cases if a js error in the dialog occurs the dialog is closed why we make sure to clean up.
            // Otherwise we focus the dialog
            window.top.EPiOpenedDialog._CleanUpAndReturn(null);
        }
        else
        {
            window.top.EPiOpenedDialog._dialog.focus();
        }
    }
}

// Clean up the DOM elements created by this dialog
_p._CleanElements = function()
{
    if (window.top.epiDialogCover)
    {
        window.top.epiDialogCover.style.display = "none";
    }
}

// Clean up properties of this dialog
_p._CleanDialog = function()
{
    for (var prop in this)
    {
        if (prop != "callbackMethod" && prop != "callbackArguments" && prop != "_opener")
        {
            this[prop] = null;
            delete this[prop];
        }
    }
}

// Open up Report Center
EPi.ReportWindowOpen = function()
{
    var _url = EPi.ResolveUrlFromUI("Report/Default.aspx"); 
    var _availableHeight = window.screen.availHeight;
    var _availableWidth = window.screen.availWidth;
    var _opener = window.top;
    
    // Links in Report Center should be able to communicate/load pages in EPiServer UI main window why we have to set the name of opening window.
    // This makes it possible to use target attribute on links with the value "EPiServerMainUI".
    _opener.name = "EPiServerMainUI";
    
    var _width = Math.min(_availableWidth, 1024);
    var _height = Math.min(_availableHeight, 768);
    
    var _left;
    var _top;
    
    if (_opener.innerWidth)
    {
        _left = _opener.screenX + _opener.innerWidth/2 - _width/2;
        _top = _opener.screenY + _opener.innerHeight/2 - _height/2;
    }
    else
    {
        _left = _opener.screenLeft + _opener.document.body.offsetWidth/2 - _width/2;
        _top = _opener.screenTop + _opener.document.body.offsetHeight/2 - _height/2;
    }
    
    // Make sure the dialog size isn't larger than screen real estate.
    if (_width == _availableWidth)
    {
        _width -= 50;
        _left = 20;
    }
    if (_height == _availableHeight)
    {
        _height -= 50;
        _top = 20;
    }
    
    var reportCenter = _opener.open(_url, "ReportCenter", "width=" + _width + ", height=" + _height + ", top=" + _top + ", left=" + _left + ", status=no, resizable, scrollbars");
    reportCenter.resizeTo(_width, _height);
    reportCenter.focus();
}

// Returns true if the specified Array contains the specified value, otherwise false is returned.
EPi.ArrayContains = function(array, value)
{
    if (array == null || value == null)
    {
    	return false;
    }
    
    var i;
    var len = array.length;
    for(i = 0; i < len; i++)
    {
        if (array[i] == value) 
        {
        	return true;
        }
    }

    return false;
}

// Searches the string for a word, i.e a substring surrounded with spaces or beginning/end of line. 
EPi.StringContainsWord = function(str, word)
{
	if (str == null || word == null)
	{
	    return false;
	}
    return (new RegExp("(?:\\s|^)" + word + "(?:\\s|$)")).test(str);
}

// HtmlDecode http://lab.msdn.microsoft.com/annotations/htmldecode.js 
//   client side version of the useful Server.HtmlDecode method 
//   takes one string (encoded) and returns another (decoded)

EPi.HtmlDecode = function(s) 
{
      var out = ""; 
      if (s==null || s == "") return; 
      
      var l = s.length; 

      for (var i=0; i<l; i++) 
      { 
            var ch = s.charAt(i);             
            if (ch == '&') 
            { 
                var semicolonIndex = s.indexOf(';', i+1); 
                if (semicolonIndex > 0) 
                { 
                        var entity = s.substring(i + 1, semicolonIndex); 
                        if (entity.length > 1 && entity.charAt(0) == '#') 
                        { 
                              if (entity.charAt(1) == 'x' || entity.charAt(1) == 'X') 
                              {
                                    ch = String.fromCharCode(eval('0'+entity.substring(1))); 
                              }
                              else 
                              {
                                    ch = String.fromCharCode(eval(entity.substring(1))); 
                              }
                        } 
                        else 
                        { 
                              switch (entity) 
                              { 
                                    case 'quot': ch = String.fromCharCode(0x0022); break; 
                                    case 'amp': ch = String.fromCharCode(0x0026); break; 
                                    case 'lt': ch = String.fromCharCode(0x003c); break; 
                                    case 'gt': ch = String.fromCharCode(0x003e); break; 
                                    case 'nbsp': ch = String.fromCharCode(0x00a0); break; 
                                    case 'iexcl': ch = String.fromCharCode(0x00a1); break;
                                    case 'cent': ch = String.fromCharCode(0x00a2); break; 
                                    case 'pound': ch = String.fromCharCode(0x00a3); break;
                                    case 'curren': ch = String.fromCharCode(0x00a4); break; 
                                    case 'yen': ch = String.fromCharCode(0x00a5); break; 
                                    case 'brvbar': ch = String.fromCharCode(0x00a6); break; 
                                    case 'sect': ch = String.fromCharCode(0x00a7); break; 
                                    case 'uml': ch = String.fromCharCode(0x00a8); break; 
                                    case 'copy': ch = String.fromCharCode(0x00a9); break; 
                                    case 'ordf': ch = String.fromCharCode(0x00aa); break; 
                                    case 'laquo': ch = String.fromCharCode(0x00ab); break; 
                                    case 'not': ch = String.fromCharCode(0x00ac); break; 
                                    case 'shy': ch = String.fromCharCode(0x00ad); break; 
                                    case 'reg': ch = String.fromCharCode(0x00ae); break; 
                                    case 'macr': ch = String.fromCharCode(0x00af); break; 
                                    case 'deg': ch = String.fromCharCode(0x00b0); break; 
                                    case 'plusmn': ch = String.fromCharCode(0x00b1); break; 
                                    case 'sup2': ch = String.fromCharCode(0x00b2); break; 
                                    case 'sup3': ch = String.fromCharCode(0x00b3); break; 
                                    case 'acute': ch = String.fromCharCode(0x00b4); break; 
                                    case 'micro': ch = String.fromCharCode(0x00b5); break; 
                                    case 'para': ch = String.fromCharCode(0x00b6); break; 
                                    case 'middot': ch = String.fromCharCode(0x00b7); break; 
                                    case 'cedil': ch = String.fromCharCode(0x00b8); break; 
                                    case 'sup1': ch = String.fromCharCode(0x00b9); break; 
                                    case 'ordm': ch = String.fromCharCode(0x00ba); break; 
                                    case 'raquo': ch = String.fromCharCode(0x00bb); break; 
                                    case 'frac14': ch = String.fromCharCode(0x00bc); break; 
                                    case 'frac12': ch = String.fromCharCode(0x00bd); break; 
                                    case 'frac34': ch = String.fromCharCode(0x00be); break; 
                                    case 'iquest': ch = String.fromCharCode(0x00bf); break; 
                                    case 'Agrave': ch = String.fromCharCode(0x00c0); break; 
                                    case 'Aacute': ch = String.fromCharCode(0x00c1); break; 
                                    case 'Acirc': ch = String.fromCharCode(0x00c2); break; 
                                    case 'Atilde': ch = String.fromCharCode(0x00c3); break; 
                                    case 'Auml': ch = String.fromCharCode(0x00c4); break; 
                                    case 'Aring': ch = String.fromCharCode(0x00c5); break; 
                                    case 'AElig': ch = String.fromCharCode(0x00c6); break; 
                                    case 'Ccedil': ch = String.fromCharCode(0x00c7); break; 
                                    case 'Egrave': ch = String.fromCharCode(0x00c8); break; 
                                    case 'Eacute': ch = String.fromCharCode(0x00c9); break; 
                                    case 'Ecirc': ch = String.fromCharCode(0x00ca); break; 
                                    case 'Euml': ch = String.fromCharCode(0x00cb); break; 
                                    case 'Igrave': ch = String.fromCharCode(0x00cc); break; 
                                    case 'Iacute': ch = String.fromCharCode(0x00cd); break; 
                                    case 'Icirc': ch = String.fromCharCode(0x00ce ); break; 
                                    case 'Iuml': ch = String.fromCharCode(0x00cf); break; 
                                    case 'ETH': ch = String.fromCharCode(0x00d0); break; 
                                    case 'Ntilde': ch = String.fromCharCode(0x00d1); break; 
                                    case 'Ograve': ch = String.fromCharCode(0x00d2); break; 
                                    case 'Oacute': ch = String.fromCharCode(0x00d3); break; 
                                    case 'Ocirc': ch = String.fromCharCode(0x00d4); break; 
                                    case 'Otilde': ch = String.fromCharCode(0x00d5); break; 
                                    case 'Ouml': ch = String.fromCharCode(0x00d6); break; 
                                    case 'times': ch = String.fromCharCode(0x00d7); break; 
                                    case 'Oslash': ch = String.fromCharCode(0x00d8); break; 
                                    case 'Ugrave': ch = String.fromCharCode(0x00d9); break; 
                                    case 'Uacute': ch = String.fromCharCode(0x00da); break; 
                                    case 'Ucirc': ch = String.fromCharCode(0x00db); break; 
                                    case 'Uuml': ch = String.fromCharCode(0x00dc); break; 
                                    case 'Yacute': ch = String.fromCharCode(0x00dd); break; 
                                    case 'THORN': ch = String.fromCharCode(0x00de); break; 
                                    case 'szlig': ch = String.fromCharCode(0x00df); break; 
                                    case 'agrave': ch = String.fromCharCode(0x00e0); break; 
                                    case 'aacute': ch = String.fromCharCode(0x00e1); break; 
                                    case 'acirc': ch = String.fromCharCode(0x00e2); break; 
                                    case 'atilde': ch = String.fromCharCode(0x00e3); break; 
                                    case 'auml': ch = String.fromCharCode(0x00e4); break; 
                                    case 'aring': ch = String.fromCharCode(0x00e5); break; 
                                    case 'aelig': ch = String.fromCharCode(0x00e6); break; 
                                    case 'ccedil': ch = String.fromCharCode(0x00e7); break; 
                                    case 'egrave': ch = String.fromCharCode(0x00e8); break; 
                                    case 'eacute': ch = String.fromCharCode(0x00e9); break; 
                                    case 'ecirc': ch = String.fromCharCode(0x00ea); break; 
                                    case 'euml': ch = String.fromCharCode(0x00eb); break; 
                                    case 'igrave': ch = String.fromCharCode(0x00ec); break; 
                                    case 'iacute': ch = String.fromCharCode(0x00ed); break; 
                                    case 'icirc': ch = String.fromCharCode(0x00ee); break; 
                                    case 'iuml': ch = String.fromCharCode(0x00ef); break; 
                                    case 'eth': ch = String.fromCharCode(0x00f0); break; 
                                    case 'ntilde': ch = String.fromCharCode(0x00f1); break; 
                                    case 'ograve': ch = String.fromCharCode(0x00f2); break; 
                                    case 'oacute': ch = String.fromCharCode(0x00f3); break; 
                                    case 'ocirc': ch = String.fromCharCode(0x00f4); break; 
                                    case 'otilde': ch = String.fromCharCode(0x00f5); break; 
                                    case 'ouml': ch = String.fromCharCode(0x00f6); break; 
                                    case 'divide': ch = String.fromCharCode(0x00f7); break; 
                                    case 'oslash': ch = String.fromCharCode(0x00f8); break; 
                                    case 'ugrave': ch = String.fromCharCode(0x00f9); break; 
                                    case 'uacute': ch = String.fromCharCode(0x00fa); break; 
                                    case 'ucirc': ch = String.fromCharCode(0x00fb); break; 
                                    case 'uuml': ch = String.fromCharCode(0x00fc); break; 
                                    case 'yacute': ch = String.fromCharCode(0x00fd); break; 
                                    case 'thorn': ch = String.fromCharCode(0x00fe); break; 
                                    case 'yuml': ch = String.fromCharCode(0x00ff); break; 
                                    case 'OElig': ch = String.fromCharCode(0x0152); break; 
                                    case 'oelig': ch = String.fromCharCode(0x0153); break; 
                                    case 'Scaron': ch = String.fromCharCode(0x0160); break; 
                                    case 'scaron': ch = String.fromCharCode(0x0161); break; 
                                    case 'Yuml': ch = String.fromCharCode(0x0178); break; 
                                    case 'fnof': ch = String.fromCharCode(0x0192); break; 
                                    case 'circ': ch = String.fromCharCode(0x02c6); break; 
                                    case 'tilde': ch = String.fromCharCode(0x02dc); break; 
                                    case 'Alpha': ch = String.fromCharCode(0x0391); break; 
                                    case 'Beta': ch = String.fromCharCode(0x0392); break; 
                                    case 'Gamma': ch = String.fromCharCode(0x0393); break; 
                                    case 'Delta': ch = String.fromCharCode(0x0394); break; 
                                    case 'Epsilon': ch = String.fromCharCode(0x0395); break; 
                                    case 'Zeta': ch = String.fromCharCode(0x0396); break; 
                                    case 'Eta': ch = String.fromCharCode(0x0397); break; 
                                    case 'Theta': ch = String.fromCharCode(0x0398); break; 
                                    case 'Iota': ch = String.fromCharCode(0x0399); break; 
                                    case 'Kappa': ch = String.fromCharCode(0x039a); break; 
                                    case 'Lambda': ch = String.fromCharCode(0x039b); break; 
                                    case 'Mu': ch = String.fromCharCode(0x039c); break; 
                                    case 'Nu': ch = String.fromCharCode(0x039d); break; 
                                    case 'Xi': ch = String.fromCharCode(0x039e); break; 
                                    case 'Omicron': ch = String.fromCharCode(0x039f); break; 
                                    case 'Pi': ch = String.fromCharCode(0x03a0); break; 
                                    case ' Rho ': ch = String.fromCharCode(0x03a1); break; 
                                    case 'Sigma': ch = String.fromCharCode(0x03a3); break; 
                                    case 'Tau': ch = String.fromCharCode(0x03a4); break; 
                                    case 'Upsilon': ch = String.fromCharCode(0x03a5); break; 
                                    case 'Phi': ch = String.fromCharCode(0x03a6); break; 
                                    case 'Chi': ch = String.fromCharCode(0x03a7); break; 
                                    case 'Psi': ch = String.fromCharCode(0x03a8); break; 
                                    case 'Omega': ch = String.fromCharCode(0x03a9); break; 
                                    case 'alpha': ch = String.fromCharCode(0x03b1); break; 
                                    case 'beta': ch = String.fromCharCode(0x03b2); break; 
                                    case 'gamma': ch = String.fromCharCode(0x03b3); break; 
                                    case 'delta': ch = String.fromCharCode(0x03b4); break; 
                                    case 'epsilon': ch = String.fromCharCode(0x03b5); break; 
                                    case 'zeta': ch = String.fromCharCode(0x03b6); break; 
                                    case 'eta': ch = String.fromCharCode(0x03b7); break; 
                                    case 'theta': ch = String.fromCharCode(0x03b8); break; 
                                    case 'iota': ch = String.fromCharCode(0x03b9); break; 
                                    case 'kappa': ch = String.fromCharCode(0x03ba); break; 
                                    case 'lambda': ch = String.fromCharCode(0x03bb); break; 
                                    case 'mu': ch = String.fromCharCode(0x03bc); break; 
                                    case 'nu': ch = String.fromCharCode(0x03bd); break; 
                                    case 'xi': ch = String.fromCharCode(0x03be); break; 
                                    case 'omicron': ch = String.fromCharCode(0x03bf); break; 
                                    case 'pi': ch = String.fromCharCode(0x03c0); break; 
                                    case 'rho': ch = String.fromCharCode(0x03c1); break; 
                                    case 'sigmaf': ch = String.fromCharCode(0x03c2); break; 
                                    case 'sigma': ch = String.fromCharCode(0x03c3); break; 
                                    case 'tau': ch = String.fromCharCode(0x03c4); break; 
                                    case 'upsilon': ch = String.fromCharCode(0x03c5); break; 
                                    case 'phi': ch = String.fromCharCode(0x03c6); break; 
                                    case 'chi': ch = String.fromCharCode(0x03c7); break; 
                                    case 'psi': ch = String.fromCharCode(0x03c8); break; 
                                    case 'omega': ch = String.fromCharCode(0x03c9); break; 
                                    case 'thetasym': ch = String.fromCharCode(0x03d1); break; 
                                    case 'upsih': ch = String.fromCharCode(0x03d2); break; 
                                    case 'piv': ch = String.fromCharCode(0x03d6); break; 
                                    case 'ensp': ch = String.fromCharCode(0x2002); break; 
                                    case 'emsp': ch = String.fromCharCode(0x2003); break; 
                                    case 'thinsp': ch = String.fromCharCode(0x2009); break; 
                                    case 'zwnj': ch = String.fromCharCode(0x200c); break; 
                                    case 'zwj': ch = String.fromCharCode(0x200d); break; 
                                    case 'lrm': ch = String.fromCharCode(0x200e); break; 
                                    case 'rlm': ch = String.fromCharCode(0x200f); break; 
                                    case 'ndash': ch = String.fromCharCode(0x2013); break; 
                                    case 'mdash': ch = String.fromCharCode(0x2014); break; 
                                    case 'lsquo': ch = String.fromCharCode(0x2018); break; 
                                    case 'rsquo': ch = String.fromCharCode(0x2019); break; 
                                    case 'sbquo': ch = String.fromCharCode(0x201a); break; 
                                    case 'ldquo': ch = String.fromCharCode(0x201c); break; 
                                    case 'rdquo': ch = String.fromCharCode(0x201d); break; 
                                    case 'bdquo': ch = String.fromCharCode(0x201e); break; 
                                    case 'dagger': ch = String.fromCharCode(0x2020); break; 
                                    case 'Dagger': ch = String.fromCharCode(0x2021); break; 
                                    case 'bull': ch = String.fromCharCode(0x2022); break; 
                                    case 'hellip': ch = String.fromCharCode(0x2026); break; 
                                    case 'permil': ch = String.fromCharCode(0x2030); break; 
                                    case 'prime': ch = String.fromCharCode(0x2032); break; 
                                    case 'Prime': ch = String.fromCharCode(0x2033); break; 
                                    case 'lsaquo': ch = String.fromCharCode(0x2039); break; 
                                    case 'rsaquo': ch = String.fromCharCode(0x203a); break; 
                                    case 'oline': ch = String.fromCharCode(0x203e); break; 
                                    case 'frasl': ch = String.fromCharCode(0x2044); break; 
                                    case 'euro': ch = String.fromCharCode(0x20ac); break; 
                                    case 'image': ch = String.fromCharCode(0x2111); break; 
                                    case 'weierp': ch = String.fromCharCode(0x2118); break; 
                                    case 'real': ch = String.fromCharCode(0x211c); break; 
                                    case 'trade': ch = String.fromCharCode(0x2122); break; 
                                    case 'alefsym': ch = String.fromCharCode(0x2135); break; 
                                    case 'larr': ch = String.fromCharCode(0x2190); break; 
                                    case 'uarr': ch = String.fromCharCode(0x2191); break; 
                                    case 'rarr': ch = String.fromCharCode(0x2192); break; 
                                    case 'darr': ch = String.fromCharCode(0x2193); break; 
                                    case 'harr': ch = String.fromCharCode(0x2194); break; 
                                    case 'crarr': ch = String.fromCharCode(0x21b5); break; 
                                    case 'lArr': ch = String.fromCharCode(0x21d0); break; 
                                    case 'uArr': ch = String.fromCharCode(0x21d1); break; 
                                    case 'rArr': ch = String.fromCharCode(0x21d2); break; 
                                    case 'dArr': ch = String.fromCharCode(0x21d3); break; 
                                    case 'hArr': ch = String.fromCharCode(0x21d4); break; 
                                    case 'forall': ch = String.fromCharCode(0x2200); break; 
                                    case 'part': ch = String.fromCharCode(0x2202); break; 
                                    case 'exist': ch = String.fromCharCode(0x2203); break; 
                                    case 'empty': ch = String.fromCharCode(0x2205); break; 
                                    case 'nabla': ch = String.fromCharCode(0x2207); break; 
                                    case 'isin': ch = String.fromCharCode(0x2208); break; 
                                    case 'notin': ch = String.fromCharCode(0x2209); break; 
                                    case 'ni': ch = String.fromCharCode(0x220b); break; 
                                    case 'prod': ch = String.fromCharCode(0x220f); break; 
                                    case 'sum': ch = String.fromCharCode(0x2211); break; 
                                    case 'minus': ch = String.fromCharCode(0x2212); break; 
                                    case 'lowast': ch = String.fromCharCode(0x2217); break; 
                                    case 'radic': ch = String.fromCharCode(0x221a); break; 
                                    case 'prop': ch = String.fromCharCode(0x221d); break; 
                                    case 'infin': ch = String.fromCharCode(0x221e); break; 
                                    case 'ang': ch = String.fromCharCode(0x2220); break; 
                                    case 'and': ch = String.fromCharCode(0x2227); break; 
                                    case 'or': ch = String.fromCharCode(0x2228); break; 
                                    case 'cap': ch = String.fromCharCode(0x2229); break; 
                                    case 'cup': ch = String.fromCharCode(0x222a); break; 
                                    case 'int': ch = String.fromCharCode(0x222b); break; 
                                    case 'there4': ch = String.fromCharCode(0x2234); break; 
                                    case 'sim': ch = String.fromCharCode(0x223c); break; 
                                    case 'cong': ch = String.fromCharCode(0x2245); break; 
                                    case 'asymp': ch = String.fromCharCode(0x2248); break; 
                                    case 'ne': ch = String.fromCharCode(0x2260); break; 
                                    case 'equiv': ch = String.fromCharCode(0x2261); break; 
                                    case 'le': ch = String.fromCharCode(0x2264); break; 
                                    case 'ge': ch = String.fromCharCode(0x2265); break; 
                                    case 'sub': ch = String.fromCharCode(0x2282); break; 
                                    case 'sup': ch = String.fromCharCode(0x2283); break; 
                                    case 'nsub': ch = String.fromCharCode(0x2284); break; 
                                    case 'sube': ch = String.fromCharCode(0x2286); break; 
                                    case 'supe': ch = String.fromCharCode(0x2287); break; 
                                    case 'oplus': ch = String.fromCharCode(0x2295); break; 
                                    case 'otimes': ch = String.fromCharCode(0x2297); break; 
                                    case 'perp': ch = String.fromCharCode(0x22a5); break; 
                                    case 'sdot': ch = String.fromCharCode(0x22c5); break; 
                                    case 'lceil': ch = String.fromCharCode(0x2308); break; 
                                    case 'rceil': ch = String.fromCharCode(0x2309); break; 
                                    case 'lfloor': ch = String.fromCharCode(0x230a); break; 
                                    case 'rfloor': ch = String.fromCharCode(0x230b); break; 
                                    case 'lang': ch = String.fromCharCode(0x2329); break; 
                                    case 'rang': ch = String.fromCharCode(0x232a); break; 
                                    case 'loz': ch = String.fromCharCode(0x25ca); break; 
                                    case 'spades': ch = String.fromCharCode(0x2660); break; 
                                    case 'clubs': ch = String.fromCharCode(0x2663); break; 
                                    case 'hearts': ch = String.fromCharCode(0x2665); break; 
                                    case 'diams': ch = String.fromCharCode(0x2666); break; 
                                    default: ch = ''; break; 
                              }
                        } 
                        i = semicolonIndex; 
                  } 
            } 

            out += ch; 
      } 
      return out;
}

// EPi.FireDefaultButton is used to override the ASP.Net WebForm_FireDefaultButton to make the use of Form.DefaultButton
// work properly across web browsers. Allows enter in textareas in non IE browsers and do not trigger 
// default button click when enter click on other buttons and links which has received focus.
EPi.FireDefaultButton = function(e, defaultButtonId) 
{
    // OkToFire determines if the event target allows defaultbutton click.
    this.OkToFire = function(e, defaultButton) {
        var node = e.srcElement || e.target;

        if (!node && !node.nodeName) {
            return true;
        }
        if (node == defaultButton) {
            return false;
        }
        switch (node.nodeName.toUpperCase()) {
            case "TEXTAREA":
            case "A":
            case "BUTTON":
                return false;
                break;
            case "INPUT":
                switch (node.type.toUpperCase()) {
                    case "BUTTON": case "SUBMIT": case "IMAGE": case "RESET": case "FILE":
                        return false;
                }
                return true;
                break;
            default:
                return true;
        }
    }

    // Check for correct keycode (Enter = 13) and take proper action.
    var defaultButton = document.getElementById(defaultButtonId) || EPi.defaultButton;
    if (e.keyCode == 13) {
        if (this.OkToFire(e, defaultButton)) {
            if (defaultButton && defaultButton.click != "undefined") {
                defaultButton.click();

                e.cancelBubble = true;
                if (e.stopPropagation) e.stopPropagation();
                return false;
            }
        }
    }
    return true;
}

EPi.InvokeFireDefaultButton = function(e) 
{
    EPi.RemoveEventListener(window, "load", EPi.InvokeFireDefaultButton);

    // Check of ASP.Net WebForm_FireDefaultButton script is registered
    // and if so override it.
    if (typeof (window.WebForm_FireDefaultButton) != "undefined" &&
            typeof (EPi.GetForm().onkeypress) != "undefined" &&
            EPi.GetForm().onkeypress != null &&
            EPi.GetForm().onkeypress.toString().indexOf("WebForm_FireDefaultButton") > 0) {
        window.WebForm_FireDefaultButton = function(e, defaultButtonId) {
            return EPi.FireDefaultButton(e, defaultButtonId);
        }
    }
}

if (typeof (EPi.AddWindowLoadListener) == "function") 
{
    EPi.AddWindowLoadListener(EPi.InvokeFireDefaultButton);
}