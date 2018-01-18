@charset "UTF-8";
/* CSS Document */

body {background-color:#fcfcfc; font-family:"Helvetica Neue", Helvetica, Arial, sans-serif; color:#222;}
.container {width:960px; margin:0 auto; position:relative;}
.hidden { display: none; }
a {text-decoration:none;}
a:hover {text-decoration:underline;}

#header {width:100%; padding-bottom: 50px;}
#header img {max-width: 100%; height:auto; float:right;}
h1 {color: #000000; font-size:44px; font-weight:400; margin:1em 0;}
h2 {font-weight:200; color:#222; font-size:40px; margin-bottom: 24px;}
h3 {font-weight: 200; color: #333;	font-size: 28px; line-height: 1.1; margin: 36px 0 10px;}
h4 {font-weight:normal; color:#051; font-size:16px; margin-top:30px; }
.highlight {font-size:.9em; color:#232323; line-height:22.5px; padding-bottom:20px;}
.highlight li {float:left; font-size: 15px; font-weight:500; background-color: #09c; color:white;padding: 5px 10px; margin:1px 2px; border: 1px solid #fff; -webkit-border-top-left-radius:15px; -moz-border-radius-topleft:15px; border-top-left-radius:15px; -webkit-border-top-right-radius:15px; -moz-border-radius-topright:15px; border-top-right-radius:15px; -webkit-border-bottom-right-radius:15px; -moz-border-radius-bottomright:15px; border-bottom-right-radius:15px; -webkit-border-bottom-left-radius:15px; -moz-border-radius-bottomleft:15px; border-bottom-left-radius:15px;box-sizing:border-box;}
.highlight li:hover {background-color:#069}
.highlight li a {color:#fff;} .highlight li a:hover {text-decoration:none;}

@media all and (max-width:568px){
#header h1 {display: none;}
#header img {float:none; margin:0 auto; max-width: 250px;}
}
@media all and (max-width: 768px){
#header img { max-width: 250px;}
}

#content {clear:both;}
#content em {color:#333; font-style:italic;}
#content p {font-size:.8em; line-height:1.5em; margin:10px 0;}
#content form {width: 100%;}
#content form input {padding:10px; size:12px; color:#333; border:1px solid #ddd; width:330px; }
#content form input[type="text"] { margin: 5px 10px 5px 0; }
#content form input.input-wide { width: 600px; }
#content form input.check {width:1.5em; border: 0 none;}
#content form textarea {width:600px; height:150px; padding:10px; size:12px; color:#333; border:1px solid #ddd;}
#content hr { border: 0; height: 0; border-top: 1px solid rgba(0, 0, 0, 0.2); border-bottom: 1px solid rgba(255, 255, 255, 0.2);}
#content form ul li {font-size:13px; color:#333; margin:3px 0;}
#content form ul.stacked li {width:220px; float:left; display:block;}
#content form #vet-status-details > label { display: inline-block; width: 14em; }
#content form #vet-status-details > input { width: 140px; }
#content form #vet-status-details > select { width: 160px; }
#content form #vet-date { width: 100px; }
#content form .vet-doc-upload-label { width: 12em; display: inline-block; }
#content form input[type="file"] { border: 0 none; padding: 0; }
#content form input[type="submit"] { font-size: 15px; background-color: #09c; padding: 10px; size: 12px; color: #FFF; border: 1px solid; width: 235px; -webkit-border-top-left-radius:15px; -moz-border-radius-topleft:15px;	border-top-left-radius:15px;	-webkit-border-top-right-radius:15px; -moz-border-radius-topright:15px; border-top-right-radius:15px; -webkit-border-bottom-right-radius:15px; -moz-border-radius-bottomright:15px; border-bottom-right-radius:15px; -webkit-border-bottom-left-radius:15px; -moz-border-radius-bottomleft:15px; border-bottom-left-radius:15px;color:white;}
#content form input[type="submit"]:hover { background-color: #069; cursor:pointer;}
@media only screen and (min-device-width : 320px) and (max-device-width : 568px) {#content form input[type="submit"] {width: 100%;}}
@media all and (min-width : 320px) and (max-width : 568px) {#content form input[type="submit"] {width: 100%;}}

@media all and (max-width:1000px) {
body {padding:0 20px 20px 20px;}
.container {width:100%;}
}
@media all and (max-width:400px) {
#content form input {width:95%;}
#content form input[type="text"] {width:95%;}
}
@media all and (max-width: 960px){
#content form input.input-wide {width:95%;}
#content form textarea {width:95%;}
}

#content p.words-remaining-wrapper { margin: 5px 0; }
.words-remaining { color: green; }
.words-remaining.too-many { color: red; }

#contact-info label {display: inline-block; width: 200px; font-weight: bold;}
#contact-info p {margin: 0;}
@media all and (max-width: 605px) {#contact-info p {margin-bottom:1.2em;}}


.highlight.alert {
	background-color: #f2dede;
	color: #a94442;
	padding:10px;
	margin-bottom:20px;
	border:1px solid #ebccd1;
	border-radius:4px
}