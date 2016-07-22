

/*******************************************************************************
* methods of the class Pictures
*******************************************************************************/

function photoFileName(which)
{ 
    return this.listOfImages()[which];
} 

function numberPhotos()
{ 
    return this.listOfImages().length;
} 

function currentPhotoNumber()
{ 
    return this.current;
} 

function advancePhoto()
{ 
    this.current += 1;
    if (this.current >= this.numberPhotos())
    {
        this.current = 0;
    }
    return this.current;
} 

function retreatPhoto() 
{ 
	this.current -= 1;
    if (this.current < 0)
    {
    	this.current = this.numberPhotos()-1;
    }
    return this.current;
} 
	
function insertImages()
{
	var img_elements = "";
	for (var i = 0; i < this.numberPhotos(); i++)
	{	
	    img_elements += 
	        '<img class=all-images alt="" src="images/' 
	        + this.photoFileName(i) + '" />';
	}
    return img_elements;
}

/*******************************************************************************
* methods of the class Doc
*******************************************************************************/

function elementById(id) { 
    return window.document.getElementById(id);
}

function initializePhotoImgElements()
{
    this.elementById("frame-photo").innerHTML = this.photos.insertImages();
}

function refreshDomElements() {
	var current = doc.photos.currentPhotoNumber();
	
	/* hide all except one photo */
    var selected_elements = window.document.getElementsByClassName("all-images"); 
    for (var i = 0; i < selected_elements.length; i++) {
    	if (i == current) {
    		selected_elements[current].removeAttribute("hidden"); }
    	else {
    	    selected_elements[i].setAttribute("hidden", "hidden"); }
    }
    
    /* show the photo number */
    this.elementById("page").innerHTML = 
        "PAGE " + (current+1) + "<br>OF " + this.photos.numberPhotos();
        
    /* prepare the image file name for possible download */
    var image = this.elementById("download");
    image.href = "images/" + this.photos.photoFileName(current);
    image.download = "Photo_" + (current+1) + ".jpg";
} 


