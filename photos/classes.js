
/*******************************************************************************
* class Pictures
*******************************************************************************/
	
function Pictures()
{
  /* state */
  this.current = 0;

  /* methods */
  this.listOfImages = listOfImages;
  this.photoFileName = photoFileName;
  this.numberPhotos = numberPhotos;
  this.currentPhotoNumber = currentPhotoNumber;
  this.advancePhoto = advancePhoto;
  this.retreatPhoto = retreatPhoto;
  this.insertImages = insertImages;
}

/*******************************************************************************
* class Doc
*******************************************************************************/

function constructDoc()
{
	/* attributes */
	this.photos = new Pictures();
	
	/* construction */
	this.initializePhotoImgElements();
}

function Doc()
{
	/* methods */
    this.constructDoc = constructDoc;
    this.elementById = elementById;
    this.initializePhotoImgElements = initializePhotoImgElements;
    this.refreshDomElements = refreshDomElements;
}


