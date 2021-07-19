//
//SlideShow constructor
//name: class or id of container div
//slidename: class name of slide inside container
function SlideShow(name, slidename) {
    this.name = name;
    this.slideName = slidename;
    //variable to indicate first slide index
    this.firstSlideIndex = 1;
    //variable to store current slides index
    this.currentSlideIndex = this.firstSlideIndex;
    //variable to store play status of slideshow
    this._playStatus = false;
    //readonly variable to store count of number of slides in slideshow
    this._totalSlide = 0;
    //indicates delay in milliseconds between each slide
    this.slideDelay = 2000;
    //indicates whether to start auto playing the slide show
    this.autoPlay = true;
    //private function, sets display css properties and other display related setting of slideshow
    this._setDisplay = _setDisplay;
    //private function, reset all variable to initial state
    this._resetValues = _resetValues;
    //private function, to make a single slide visible
    this._showSlide = _showSlide;
    //public function, to start playing slideshow
    this.play = play;
    //
    //public function, to show next slide of show
    //return: true if next slide avialable, false if last slide of show
    this.moveNext = moveNext;
    //
    //public function, to show previous slide of show
    //return: true if previous slide avialable, false if firt slide of show
    this.movePrevious = movePrevious;
    //public function, start slide show
    this.start = start;
    this.pause = pause;
    this.stop = stop;
    //stores reference to setInterval function
    this._timerInterval = null;
}

function play() {
    this._playStatus = true;
    var thisContext = this;
    function timerRelay() {
        if (thisContext._playStatus) {
            if (!thisContext.moveNext()) { thisContext._resetValues(); }
        }
    }
    //call setinterval only if function is not call before
    if (this._timerInterval == null) {
        this._timerInterval = setInterval(timerRelay, this.slideDelay);
    }

}

function pause() {
    this._playStatus = false;
}

function stop() {
    this._playStatus = false;
    this._setDisplay();
    this._resetValues();
    this._showSlide(this.firstSlideIndex);

    //clear setinterval
    if (this._timerInterval != null) {
        clearInterval(this._timerInterval);
        this._timerInterval = null;
    }
}

function start() {
    this._setDisplay();
    this._resetValues();
    this._showSlide(this.firstSlideIndex);
    if (this.autoPlay) {
        this.play();
    }
}

//
//next slide
//return: if true than we can move next if false than its last slide of show
function moveNext() {
    index = this.currentSlideIndex + 1;
    if (index > this._totalSlide) index = this._totalSlide;
    this._showSlide(index);

    if (this.currentSlideIndex == this._totalSlide) {
        return false;
    }
    else {
        return true;
    }
}

//
//previous slide
//return: if true than we can move previous if false than its first slide of show
function movePrevious() {
    index = this.currentSlideIndex - 1;
    if (index < this.firstSlideIndex) index = this.firstSlideIndex;
    this._showSlide(index);

    if (this.currentSlideIndex == this.firstSlideIndex) {
        return false;
    }
    else {
        return true;
    }
}

//
//Function to set css display properties of important elements
function _setDisplay() {
    this._totalSlide = $(this.name + " > " + this.slideName).length;
    $(this.name + " > " + this.slideName).each(function (index) {
        $(this).css("display", "none");
    });
}

//
//Function to reset values to initial state
function _resetValues() {
    this.currentSlideIndex = this.firstSlideIndex - 1;
}

//
//Function hides all other slides and show one on the index provided
function _showSlide(index) {
    if (index <= this._totalSlide && index >= this.firstSlideIndex) {
        this.currentSlideIndex = index;
        $(this.name + " > " + this.slideName).each(function (i) {
            if (i == (index - 1)) {
                $(this).fadeIn(900, "linear");
            }
            else {
                $(this).css("display", "none");
            }
        });
    }
}