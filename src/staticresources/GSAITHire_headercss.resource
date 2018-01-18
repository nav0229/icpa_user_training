
/* MICRO CLEARFIX HACK */

.cf:before,
.cf:after {
    content: "";
    display: table;
}

/* For modern browsers */
.cf:after {
    clear: both;
}

.cf {
    /* For IE 6/7 (trigger hasLayout) */
    zoom: 1;
}

.header {
    border-bottom: 4px solid #3c547c;
    overflow: auto;
}

.header .logo {
    display: block;
    margin: 1em 0;
}

.header h1 {
    margin: 1em 0 0 0;
    font-family: "Avenir Next W01", Arial, sans-serif;
    font-size: 1.625em;
    font-weight: 500;
    display: inline-block;
}

.header h1 span {
    font-family: "Avenir Next W01", Arial, sans-serif;
    font-weight: bold;
}
.wrap {
    width: 90%;
    margin: 0 auto;
}
@media only screen and (min-width: 20em) {
    .header .logo {
        margin: 1em 0 0 0;
    }
    .header h1 {
        margin-bottom: .5em;
    }
} 

@media only screen and (min-width: 30em) {
    .header .logo {
        margin: 1em 0;
        float: right;
    }
}
@media only screen and (min-width: 75em) { 
    .wrap {
        max-width: 1200px;
    }
}



.img {
    border: 0;
    /* Improve IE's resizing of images */
    -ms-interpolation-mode: bicubic;
}
.img{
    /* Fluid images */
    max-width: 100%;
    _width: 100%;
}
