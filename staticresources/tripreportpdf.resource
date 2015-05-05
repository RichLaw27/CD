@page 
{
	@top-center {content: element(header);}
	@bottom-left {content: element(footer);}
	size:A4; /* A4 width and height */;
	font-family: Arial, sans-serif;
	margin: 120px 40px 50px;
	
}

div.header 
{
	/* border: 1px solid black; */
	position: running(header);
	font-size: 10pt;
	font-family: Arial, sans-serif;
	color: #DDDDDD;
	/* display: block; 
	text-align: left;*/
}
div.title
{
	float: left;
	border: 1px solid green;
	
}
div.footer 
{
	padding: 5px;
	position: running(footer);
	font-size: 10pt;
	font-family: Arial, sans-serif;
	text-align: center;
}
div.content
{
	 position: relative; 
	/*border: 1px solid red;*/
}
.confidential 
{
	font-family: Arial, sans-serif;
	font-size: 10pt;
	font-weight: bold;
	color: #FF0000;
	text-align: center;
}

.pagenumber:before 
{
	content: counter(page);
}
.pagecount:before 
{
	content: counter(pages);
}
th {
    text-align: left;
    font-weight: bold;
    white-space: nowrap;    
}

h1, h2, h3, h4, h5, h6 {
    font-family: Arial, sans-serif;
    font-size: 13pt;
    display:inline;
    vertical-align: bottom;  
    text-align: left;  
}

table  
{
	font-family: Arial, sans-serif;
	border-collapse:collapse;
	border: 1px solid #CCC;
	cellpadding: 1em;
	width: 100%;
}

img { 
	border:0; 
	text-align:right;
}

.headertable {
font-family: Arial, sans-serif;
border-collapse:collapse;
width: 100%;
border: 1px solid black;
	}

.headercol1 {
 width: 20%;
 vertical-align: top;
 font-weight: bold;
 font-size: 10pt;
 height: 2em;
  }
 .headercol2 {
 vertical-align: top;
 font-size: 10pt;
 height: 2em;
 }
  .headercol3 {
 vertical-align: top;
 font-size: 10pt;
 width:38%;
 height: 2em;
 }
 .emptycol{
 width: 2%;
 background-color: #FFF;
 }
.conrolecol1 {
 width: 70%;
 vertical-align: top;
 font-weight: bold;
 font-size: 10pt; 
 border-bottom: 1px solid #CCC;
 }
.conrolecol2 {
 border-left: 1px solid #CCC;
 border-right: 1px solid #CCC;
 border-bottom: 1px solid #CCC;
 width: 30%;
 text-align: center;
 font-size: 10pt; 
 vertical-align:top;
 
 }
.conrolecol34 {
 border-left: 1px solid #CCC;
 border-bottom: 1px solid #CCC;
 width: 30%;
 font-size: 10pt; 
 vertical-align:top;
 }
  .colsubject {
 width: 15%;
 vertical-align: top;
 font-weight: bold; 
 font-size: 10pt; 
 border-bottom: 1px solid #CCC;
 }
 .colcategory {
 width: 15%;
 vertical-align: top;
 font-size: 10pt; 
 border-bottom: 1px solid #CCC;
border-left: 1px solid #CCC;
 
 }
.colsummary {
 border-left: 1px solid #CCC;
 border-right: 1px solid #CCC;
 border-bottom: 1px solid #CCC;
 width: 40%;
 font-size: 10pt; 
 vertical-align:top;
 
 }
.colresponsible {
 border-left: 1px solid #CCC;
 border-bottom: 1px solid #CCC;
 width: 15%;
 font-size: 10pt; 
 vertical-align:top;
 }
.colduedate {
 border-left: 1px solid #CCC;
 border-bottom: 1px solid #CCC;
 width: 15%;
 font-size: 10pt; 
 vertical-align:top;
 }
 .coloppy{
 border-left: 1px solid #CCC;
 border-bottom: 1px solid #CCC;
 width: 15%;
 font-size: 10pt; 
 vertical-align:top;
 }
.widetextarea
{
width: 400px;
}