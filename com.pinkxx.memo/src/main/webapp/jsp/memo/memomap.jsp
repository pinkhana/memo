<%-- 
    Document   : memo
    Created on : 
    Author     : Ayami
--%>
<html lang="en" class="no-js">
	<head>
		<script src="jquery/DragAndDrop/js/draggabilly.pkgd.min.js"></script>
		<script src="jquery/DragAndDrop/js/dragdrop.js"></script>	
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Drag and Drop For Memo Mapping</title>
		<meta name="description" content="Inspiration for drag and drop interactions for the modern UI" />
		<meta name="keywords" content="drag and drop, interaction, inspiration, web design, ui" />
		<meta name="author" content="Codrops" />
		<link rel="shortcut icon" href="../favicon.ico">
		<!-- <link rel="stylesheet" type="text/css" href="jquery/DragAndDrop/css/normalize.css" />-->
		<link rel="stylesheet" type="text/css" href="jquery/DragAndDrop/fonts/font-awesome-4.2.0/css/font-awesome.min.css" />
		<link rel="stylesheet" type="text/css" href="jquery/DragAndDrop/css/demo.css" />
		<link rel="stylesheet" type="text/css" href="jquery/DragAndDrop/css/bottom-area.css" /> 
		<!-- <script src="jquery/DragAndDrop/js/modernizr.custom.js"></script> -->
		<script type="text/javascript">	
			<%@ include file="../../jquery/DragAndDrop/js/modernizr.custom.js" %>
			<%@ include file="../../jquery/DragAndDrop/js/draggabilly.pkgd.min.js" %>
			<%@ include file="../../jquery/DragAndDrop/js/dragdrop.js" %>
		</script>
		<script>
		$(document).ready(function(){
			doInitMemoMapList();
		});
		
		function doInitMemoFromList(){
			if(Ext.getCmp("memo-listgrid").getSelectionModel().getSelections(0).length == 0){
				Ext.Msg.show({ title:'Alert!', msg: 'Please select one row!', buttons: Ext.MessageBox.OK,closable :false,fn:function(){},icon: Ext.MessageBox.ALERT});
				return;
			}							
			var editmemoid = Ext.getCmp("memo-listgrid").getSelectionModel().getSelections(0)[0].data.id;//$.urlParam('memoidfromlist');			
			//alert(editmemoid);
			$.ajax({
			    url: "listMemoAction!getMemoMapFromByIdtoAjax.action",
			    type: "POST",
			    cache: false,
			    dataType: "json",
			    data: {
			    	editmemoid: editmemoid
			    },
			    success: function(o){
			    	//alert(o[0].mkey);
			    	var strDropAreaHtml = "<div>";
			    	for(i=0;i<4;i++){
			    		if (o[i]==null){
			    			strDropAreaHtml = strDropAreaHtml + "<div id='memo_drop_area_item_empty" + i + "' class='drop-area__item'>+</div>";
			    		} else {
			    			strDropAreaHtml = strDropAreaHtml + "<div style='clear: both;' id='memo_drop_area_item_1" + o[i].id + "' class='drop-area__item'>" + o[i].mkey + "</div>";
			    		}
			    	}
			    	strDropAreaHtml = strDropAreaHtml + "</div>";
			    	$('#drop-area').html(strDropAreaHtml);
					//$("#memo_drop_area_item_1").css("content","aaaaaaaabbb");
			    	//doInitMemoMapList();
			    	doDragDrop();
			    },
			    error: function(xhr, textStatus, errorThrown){
			    	alert("getMemoMapListAjax error!");
			    }
			});	
		}
		
		function doInitMemoMapList(){
			$.ajax({
			    url: "listMemoAction!getMemoMapListAjax.action",
			    type: "POST",
			    cache: false,
			    dataType: "json",
			    data: {
			    	//param1: $('#text1').val(),
			    	//param2: $('#text2').val()
			    },
			    success: function(o){
			    	//alert(o[0].mkey);
			    	var strGridHtml = "";
			    	for(i=0;i<16;i++){
			    		if (o[i]==null){
			    			//strGridHtml = strGridHtml + "<div class='grid__item'></div>"
			    		} else {
			    			strGridHtml = strGridHtml + "<div id='dragmemoid_" + o[i].id + "' class='grid__item'>"+o[i].mkey+"</div>"
			    		}
			    	}
			    	$('#grid').html(strGridHtml);
			    	doInitMemoFromList();
			    	//doDragDrop();
			    },
			    error: function(xhr, textStatus, errorThrown){
			    	alert("getMemoMapListAjax error!");
			    }
			});
		}
		</script>		
	</head>
	<body>
		<div id="dragdropmain" class="container">
			<div class="content">
				<header class="codrops-header"></header>
				<section class="related">
					<p>Drag Me!</p><!-- <input type="button" onclick="doInitMemoMapList();" value="Update Me!"/> -->
				</section>
				<div id="grid" class="grid clearfix">
					<!-- <div class="grid__item">aaaaa...</div>
					<div class="grid__item"><i class="fa fa-fw fa-image">bbbbbbbbbb</i></div>
					<div class="grid__item"><i class="fa fa-fw fa-image"></i></div>
					<div class="grid__item">hhhhh...</div> -->			
				</div>
				<!-- Related demos -->
				<section class="related">
					<p>Drop Me!</p>
				</section>
			</div><!-- /content -->
		</div><!-- /container -->
		<div id="drop-area" class="drop-area">
			<!-- <div>
				<div class="drop-area__item"><div class="dummy"></div></div>
			</div> -->
		</div>
		<div class="drop-overlay"></div>
		<!-- <script src="jquery/DragAndDrop/js/draggabilly.pkgd.min.js"></script>
		<script src="jquery/DragAndDrop/js/dragdrop.js"></script> -->
		<script>
			/* (function() { */	
			$.urlParam = function(name){
			    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
			    if (results==null){
			       return null;
			    }
			    else{
			       return results[1] || 0;
			    }
			}
				
			function doDragDrop(){	
				var body = document.body,
					dropArea = document.getElementById( 'drop-area' ),
					droppableArr = [], dropAreaTimeout;

				// initialize droppables
				[].slice.call( document.querySelectorAll( '#drop-area .drop-area__item' )).forEach( function( el ) {
					droppableArr.push( new Droppable( el, {
						onDrop : function( instance, draggableEl ) {
							// show checkmark inside the droppabe element
							classie.add( instance.el, 'drop-feedback' );
							clearTimeout( instance.checkmarkTimeout );
							instance.checkmarkTimeout = setTimeout( function() { 
								classie.remove( instance.el, 'drop-feedback' );
							}, 800 );
							//classie.add( instance.el, 'drop-feedback-over' );
							
							var dragmemoid = draggableEl.id.split('_')[1];
							//var editmemeid = Ext.getCmp("memo-listgrid").getSelectionModel().selections.items[0].data.id;//$.urlParam('memoidfromlist');
							if(Ext.getCmp("memo-listgrid").getSelectionModel().getSelections(0).length == 0){
								Ext.Msg.show({ title:'Alert!', msg: 'Please select one row!', buttons: Ext.MessageBox.OK,closable :false,fn:function(){},icon: Ext.MessageBox.ALERT});
								return;
							}							
							var editmemoid = Ext.getCmp("memo-listgrid").getSelectionModel().getSelections(0)[0].data.id;//$.urlParam('memoidfromlist');
							$.ajax({
							    url: "addMemoAction!addMemoMapAjax.action",
							    type: "POST",
							    cache: false,
							    dataType: "json",
							    data: {
							    	dragmemoid: dragmemoid,
							    	editmemoid: editmemoid//$('#text2').val()
							    },
							    success: function(o){
							    	//alert("ok");
							    },
							    error: function(xhr, textStatus, errorThrown){
							    	alert("addMemoMapAjax error!");
							    }
							});
							// ...
						}
					} ) );
				} );

				// initialize draggable(s)
				[].slice.call(document.querySelectorAll( '#grid .grid__item' )).forEach( function( el ) {
					new Draggable( el, droppableArr, {
						draggabilly : { containment: document.body },
						onStart : function() {
							// add class 'drag-active' to body
							classie.add( body, 'drag-active' );
							// clear timeout: dropAreaTimeout (toggle drop area)
							clearTimeout( dropAreaTimeout );
							// show dropArea
							classie.add( dropArea, 'show' );
						},
						onEnd : function( wasDropped ) {
							var afterDropFn = function() {
								// hide dropArea
								classie.remove( dropArea, 'show' );
								//remove class 'drag-active' from body
								classie.remove( body, 'drag-active' );
								//doInitMemoFromList();
								doInitMemoMapList();
							};

							if( !wasDropped ) {
								afterDropFn();
							}
							else {
								// after some time hide drop area and remove class 'drag-active' from body
								clearTimeout( dropAreaTimeout );
								dropAreaTimeout = setTimeout( afterDropFn, 400 );
							}
						}
					} );
				} );
				classie.add( dropArea, 'show' );
			}
			/* })(); */
		</script>
	</body>
</html>
