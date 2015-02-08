<%-- 
    Document   : memo
    Created on : 
    Author     : Ayami
--%>
<%@ include file="../common/pinkheader.jsp" %>
	<script type="text/javascript">	
	Ext.onReady(function(){
        /*
        var store = new Ext.data.Store
        ({
            proxy:new Ext.data.HttpProxy({url:url}),
            reader:new Ext.data.JsonReader({totalProperty:"totalProperty",root:"root",id:"ID",fields:fields})
        }); */

	    var sm = new Ext.grid.CheckboxSelectionModel();
        var cm = new Ext.grid.ColumnModel
        ([        
            sm,new Ext.grid.RowNumberer({header:"No.",width:30}),
            {id:'id',header:"ID",dataIndex:"id",width:50,hidden:false},
            {header:"MKey",dataIndex:"mkey",width:150,editor:new Ext.form.TextField()},
            {header:"Memo",dataIndex:"memo",width:300,editor:new Ext.form.TextField()},
            /* {header:"DelFlag",dataIndex:"DelFlag",width:100,renderer:function(value){if(value==false) {return "Display";} else {return "Hide";}}}, */
            {header:"CTime",dataIndex:"createdDate",width:120,renderer:Ext.util.Format.dateRenderer('Y-m-d h:i:s')}
        ]);
        cm.defaultSortable = true;
        
        /* var colModel = new Ext.grid.ColumnModel([
                                                 {id:'company',header: "Company", width: 160, sortable: true, locked:false, dataIndex: 'company'},
                                                 {header: "Price", width: 75, sortable: true, renderer: Ext.util.Format.usMoney, dataIndex: 'price'},
                                                 {header: "Change", width: 75, sortable: true, renderer: change, dataIndex: 'change'},
                                                 {header: "% Change", width: 75, sortable: true, renderer: pctChange, dataIndex: 'pctChange'},
                                                 {header: "Last Updated", width: 85, sortable: true, renderer: Ext.util.Format.dateRenderer('m/d/Y'), dataIndex: 'lastChange'}
                                             ]); */        
        
	    var memoStore = new Ext.data.JsonStore({
	        root: 'memo',
	        totalProperty: 'totalCount',
	        idProperty: 'id',
	        remoteSort: true,
	        
	        fields:["id","mkey","memo","createdDate"],
	        /* fields: [
	            {name: 'replycount', type: 'int'},
	            {name: 'lastpost', mapping: 'lastpost', type: 'date', dateFormat: 'timestamp'}
	        ], */

	        // load using script tags for cross domain, if the data in on the same domain as
	        // this page, an HttpProxy would be better
	        proxy: new Ext.data.HttpProxy({
	            url: 'listMemoAction!getListMemoAjax.action'
	        })
	    });
	    memoStore.setDefaultSort('id', 'desc');


	    // pluggable renders
	    /* function renderTopic(value, p, record){
	        return String.format(
	                '<b><a href="http://extjs.com/forum/showthread.php?t={2}" target="_blank">{0}</a></b><a href="http://extjs.com/forum/forumdisplay.php?f={3}" target="_blank">{1} Forum</a>',
	                value, record.data.forumtitle, record.id, record.data.forumid);
	    }
	    function renderLast(value, p, r){
	        return String.format('{0}<br/>by {1}', value.dateFormat('M j, Y, g:i a'), r.data['lastposter']);
	    } */

	    var pagingBar = new Ext.PagingToolbar({
	    	id: 'memoPagingBar',
	        pageSize: 20,
	        store: memoStore,
	        displayInfo: true,
	        displayMsg: 'Displaying Memos {0} - {1} of {2}',
	        emptyMsg: "No memo to display",
	        
	        items:[
	            '-', {
	            pressed: false,
	            enableToggle:true,
	            text: 'Add Me(^_^)',
	            //cls: 'x-btn-text-icon details',
	            toggleHandler: function(btn, pressed){
	            	//memoAddWindow.hide();
	                //var view = memoListGrid.getView();
	                //view.showPreview = pressed;
	                //view.refresh();
	                if(pressed)
	                	memoAddWindow.show();
	                else
	                	memoAddWindow.hide();
	            }
	        }]
	    });

	    /* var memoListGrid = new Ext.grid.GridPanel({
	        trackMouseOver:false,
	        disableSelection:true,
	        loadMask: true,
	        // grid columns

	        // customize view config
	        /* viewConfig: {
	            forceFit:true,
	            enableRowBody:true,
	            showPreview:true,
	            getRowClass : function(record, rowIndex, p, store){
	                if(this.showPreview){
	                    p.body = '<p>'+record.data.excerpt+'</p>';
	                    return 'x-grid3-row-expanded';
	                }
	                return 'x-grid3-row-collapsed';
	            }
	        }, 
	    });*/
	    
		/**
		 * @class Ext.ux.SliderTip
		 * @extends Ext.Tip
		 * Simple plugin for using an Ext.Tip with a slider to show the slider value
		 */
		Ext.ux.SliderTip = Ext.extend(Ext.Tip, {
		    minWidth: 10,
		    offsets : [0, -10],
		    init : function(slider){
		        slider.on('dragstart', this.onSlide, this);
		        slider.on('drag', this.onSlide, this);
		        slider.on('dragend', this.hide, this);
		        slider.on('destroy', this.destroy, this);
		    },

		    onSlide : function(slider){
		        this.show();
		        this.body.update(this.getText(slider));
		        this.doAutoWidth();
		        this.el.alignTo(slider.thumb, 'b-t?', this.offsets);
		    },

		    getText : function(slider){
		        return slider.getValue();
		    }
		});
		
	    var memoAddWinForm = new Ext.form.FormPanel({
	        baseCls: 'x-plain',
	        labelWidth: 55,
	        url:'addMemoAction!addMemoAjax.action',
	        defaultType: 'textfield',

	        items: [{
	            fieldLabel: 'MKey',
	            name: 'mkey',
	            allowBlank:false,
	            anchor:'100%'  // anchor width by percentage
	        }, {
	        	fieldLabel: 'Memo',
	            xtype: 'textarea',
	            hideLabel: true,
	            name: 'memo',
	            allowBlank:false,
	            anchor: '100% -53'  // anchor width by percentage and height by raw adjustment
	        }]
	    });

	    //Add Window
	    var memoAddWindow = new Ext.Window({
	        title: 'Add Me(^_^)',
	        width: 500,
	        height:300,
	        minWidth: 300,
	        minHeight: 200,
	        layout: 'fit',
	        plain:true,
	        bodyStyle:'padding:5px;',
	        buttonAlign:'center',
	        items: memoAddWinForm,
	        closable: false,

	        buttons: [{
	            text: 'Insert',
	            handler  : function(){
	            	if(memoAddWinForm.getForm().isValid()){
	            		memoAddWinForm.getForm().submit({
	                        url: 'addMemoAction!addMemoAjax.action',
	                        waitMsg:'Insert Data...',
	                        success: function(){
	    	            		memoStore.reload({params:{start:0, limit:20}});
	    	            		//Ext.getCmp("memo-listgrid").store.reload();
	                        }
	                    });	            		
	            	}
	            }            
	        },{
	            text: 'Clear',
	            handler  : function(){
	            	//Ext.getCmp("").setValue("");
	            	memoAddWinForm.getForm().reset();
	            } 	            
	        },{
	            text: 'Over',
	            handler  : function(){
	            	//memoAddWindow.hide();
	            	//Ext.getCmp("memo-form")
	            	pagingBar.items.items[12].toggle();
	            } 	            
	        }]
	    });
	    
	    var memoGridForm = new Ext.FormPanel({
	        id: 'memo-form',
	        frame: false,
	        labelAlign: 'left',
	        title: 'Memo - Ayami*~',
	        bodyStyle:'padding:5px;',
	    	style: {
	    		'margin-top': '10px'
	    	},	        
	        width: 960,
	        layout: 'column',	// Specifies that the items will now be arranged in columns
	        items: [{
	            columnWidth: 0.75,
	            layout: 'fit',
	            items: {          		
		            xtype: 'grid',
		            id: 'memo-listgrid',
		            ds: memoStore,
		            cm: cm,
			        trackMouseOver: true,
			        disableSelection:false,
			        singleSelect: false,
		            sm: new Ext.grid.RowSelectionModel({
		                singleSelect: false,
		                listeners: {
		                    rowselect: function(sm, row, rec) {
		                        Ext.getCmp("memo-form").getForm().loadRecord(rec);
		                        if(Ext.getCmp("memoMapPanel").collapsed == false) doInitMemoMapList();
		                    }
		                }
		            }), 
	    	        loadMask: true,
		            autoExpandColumn: 'id',
		            height: 500,
		            title:'Memo List',
		            border: true,
			        listeners: {
			        	render: function(g) {
			        		g.getSelectionModel().selectRow(0);
			        		/* var memoMapPanel = Ext.getCmp("memoMapPanel")
			        		if(memoMapPanel == null){
			        			alert("memoMapPanel==null");
			        		}else{
			        			alert("memoMapPanel<>null");
			        		} */
			        	},
			        	delay: 10 // Allow rows to be rendered.
			        },
	        		bbar: pagingBar
	        	}
	        },{
	        	columnWidth: 0.25,
	            xtype: 'fieldset',
	            labelWidth: 40,
	            title:'Edit Me',
	            defaults: {width: 140},	// Default config options for child items
	            defaultType: 'textfield',
	            //autoHeight: true,
	            height: 400,
	            bodyStyle: Ext.isIE ? 'padding:0 0 5px 15px;' : 'padding:10px 15px;',
	            border: false,
	            style: {
	                "margin-left": "10px", // when you add custom margin in IE 6...
	                "margin-right": Ext.isIE6 ? (Ext.isStrict ? "-10px" : "-13px") : "0"  // you have to adjust for it somewhere else
	            },
		        items: [{
		            fieldLabel: 'ID',
		            //disabled: true,
		            readOnly: true,
		            name: 'id',
		            allowBlank:false,
		            blankText: 'ID is required',
		            anchor:'100%'  // anchor width by percentage
		        },{
		            fieldLabel: 'MKey',
		            name: 'mkey',
		            allowBlank:false,
		            blankText: 'MKey is required',
		            anchor:'100%'  // anchor width by percentage
		        }, {
		        	fieldLabel: 'Memo',
		            xtype: 'textarea',
		            hideLabel: true,
		            name: 'memo',
		            allowBlank:false,
		            blankText: 'Memo is required',
		            anchor: '100% -53'  // anchor width by percentage and height by raw adjustment
		        }],
		        buttons: [{
		            text: 'Update',
		            handler: function(){
		                if(memoGridForm.getForm().isValid()){
		                    //var sb = Ext.getCmp('form-statusbar');
		                    //sb.showBusy('Saving form...');
		                    //memoGridForm.getEl().mask();
		                    memoGridForm.getForm().submit({
		                        url: 'listMemoAction!updateMemoAjax.action',
		                        //waitMsg:'Updating Data...',
		                        success: function(){
		                            /* sb.setStatus({
		                                text:'Form saved!', 
		                                iconCls:'',
		                                clear: true
		                            }); */
		                            //memoGridForm.getEl().unmask();
		                        	memoStore.reload({params:{start:0, limit:20}});
		                        }
		                    });
		                }
		            }
		        }]		        
	        }],
	        renderTo: 'memo-FormPanel'
	    });    
	    
	    // trigger the data store load
	    memoStore.load({params:{start:0, limit:20}});
	    
	    createMemoMap('jsp/memo/memomap.jsp', 'Memo Mapping(^_^b)');
	});
	
	function createMemoMap(url, title) {
		var memoMapPanel = new Ext.Panel({
			id: 'memoMapPanel',
			hideMode: 'visibility',
			title: title,
	    	width: 960,
	    	style: {
	    		'margin-top': '10px'
	    	},
	    	hideCollapseTool: true,
	    	titleCollapse: true,
	    	collapsible: true,
	    	collapsed: true,
			autoScroll: true,
			renderTo: 'memo-mapping',//Ext.getBody(),
			listeners: {
				/* render: function(p) {
					p.getUpdater().setRenderer({
						render: Ext.isIE ? function(el, response, scripts, callback) {
							el.update('');
							var np = el.createChild({
								tag: 'pre',
								cls: 'code',
								cn: {
									tag: 'code'
								}
							});
							var t = response.responseText.split("\n");
							var c = np.child('code', true);
							for (var i = 0, l = t.length; i < l; i++) {
								var pre = document.createElement('pre');
								if (t[i].length) {
									pre.appendChild(document.createTextNode(t[i]));
									c.appendChild(pre);
								} else if (i < (l - 1)) {
									c.appendChild(document.createElement("br"));
								}
								
							}
						} : function(el, response, scripts, callback) {
							el.update('');
							el.createChild({
								tag: 'pre',
								cls: 'code',
								cn: {
									tag: 'code',
									html: response.responseText
								}
							});
						}
					});
				}, */
				beforeexpand: function(p) {
					//p.load(url);
					p.load({ 
					    url: url, 
					    discardUrl: false, 
					    nocache: false, 
					    timeout: 30,
					    autoLoad: true,
					    scripts: true 
					}); 
				},
				single: true
			}
		});
	}
	</script> 
    	<!-- <div id="memo-grid"></div> -->
    	<div id="memo-FormPanel"></div>
    	<div id="memo-mapping"></div>

        <%-- <s:form action="addMemoAction" >
            <s:textfield name="mkey" label="Mkey" value="" />
            <s:textarea name="memo" label="Memo" value="" cols="50" rows="5" escape="false"/> 
            <s:submit />
        </s:form> --%>
        <!-- <form id="addMemoAction" name="addMemoAction" action="/memo/addMemoAction.action" method="post">
            <input type="text" name="mkey" value="" id="addMemoAction_mkey"/>
            <input type="text" name="mkey" value="" id="addMemoAction_mkey"/>
            <input type="submit" id="addMemoAction_0" value="Submit"/>
        </form> -->
        
        <%-- <h2>All Memos</h2>

        <s:if test="memoList!=null && memoList.size()> 0">
            <table border="1px" cellpadding="8px">
                <tr>
                    <th>Id</th>
                    <th>MKey</th>
                    <th>Memo</th>
                    <th>Created Date</th>
                </tr>
                <s:iterator value="memoList" status="userStatus">
                    <tr>
                        <td><s:property value="id" /></td>
                        <td><s:property value="mkey" /></td>
                        <td><s:property value="memo" /></td>
                        <td><s:date name="createdDate" format="dd/MM/yyyy" /></td>
                    </tr>
                </s:iterator>
            </table>
        </s:if> --%>
    </body>
</html>
