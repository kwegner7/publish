
/*******************************************************************************
* entry points from the document
*******************************************************************************/
var doc = new Doc(); /* this is static */

function nextPhoto()
{
    doc.photos.advancePhoto();
    doc.refreshDomElements();
} 

function prevPhoto()
{
    doc.photos.retreatPhoto();
    doc.refreshDomElements();
} 

function initialize() { 
	doc.constructDoc();
    doc.refreshDomElements();
    window.alert("Photos Have Been Loaded");
} 




