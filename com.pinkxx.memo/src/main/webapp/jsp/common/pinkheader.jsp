<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>pink xx</title>
	<style type="text/css">#header { background: url(images/cropped-pinkhana-header.png) no-repeat !important;height: 150px; }</style>
	<link rel="stylesheet" type="text/css" href="extjs22/resources/css/ext-all.css" />
	<script type="text/javascript" src="jquery/jquery-1.6.2.min.js"></script>
 	<script type="text/javascript" src="extjs22/adapter/ext/ext-base.js"></script>
    <script type="text/javascript" src="extjs22/ext-all.js"></script>
</head>

<body>

<div id="wrap">

	<div id="header"><div class="wrap"><div id="title-area"><!-- <p id="title">
	<a href="./Home - PinkHana.com_files/Home - PinkHana.com.htm" title="PinkHana.com"></a></p><p id="description"></p> -->
	</div></div></div>
	
	<div id="nav"></div>
	
	<html:errors/>
	<html:messages id="message" message="true">
	  ${message}
	</html:messages>
