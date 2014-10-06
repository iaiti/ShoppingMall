<%@ page language="java" pageEncoding="gb2312"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%! String s = "";
	
%>
<%s = request.getParameter("hide");%>
<html>
  <head>
    <title>苦丁香HTML编辑器</title>    
</head>
  <link rel="stylesheet" type="text/css" href="editor/comm.css" />
  <script language="javascript" src="editor/all.js"></script>
<script language="javascript" src="editor/editor.js"></script>
<script language="javascript" src="editor/editor_toolbar.js"></script>
<script language=javascript>
ie4=(document.all)?true:false;
ns4=(document.layers)?true:false;

function toExit(){
var args=toExit.arguments;
var visible=args[0];
  

</script>
  <body>
  <form name="form1" method="post" action="index.jsp"  onSubmit="insert();">
  <input type="hiddern" name="hide">
  <table width="751" border="0" cellpadding="2" cellspacing="3">
   
      <tr>
        <td height="286" align="right" valign="top" style="padding-top:4px">内容：</td>
        <td><textarea id="content" name="content" style="display:none;">
		<%= s%>
		
		</textarea>
            <script language="javascript">
		gFrame = 1;//1-在框架中使用编辑器
		gContentId = "content";//要载入内容的content ID
		OutputEditorLoading();
		

		</script>
  <script language="javascript">
		function insert(){
		var var1 = GetContent();
		document.form1.hide.value=var1;
		}
		

		</script>
            <iframe id="HtmlEditor" class="editor_frame" frameborder="0" marginheight="0" marginwidth="0" style="width:100%;height:300px;overflow:visible;" ></iframe></td>
      </tr>
     
      <tr>
        <td align="right">&nbsp;</td>
        <td><input name="submit" type="submit"  value="确定提交">
            
      </tr>
      <tr>
        <td align="right">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
  </table> 
  </form>

  </body>
</html>
