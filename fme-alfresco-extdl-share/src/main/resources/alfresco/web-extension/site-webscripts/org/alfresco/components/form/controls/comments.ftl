<#include "common/editorparams.inc.ftl" />
<#if (context.properties.nodeRef?? && context.properties.nodeRef?js_string?starts_with("workspace://SpacesStore")) 
|| ((form.mode == "edit" || form.mode == "view") && args.itemId?? && args.itemId?js_string?starts_with("workspace://SpacesStore"))>

<div class="form-field">

   <#if form.mode == "view">
      <div class="viewmode-field">
         <#if field.mandatory && field.value == "">
            <span class="incomplete-warning"><img src="${url.context}/res/components/form/images/warning-16.png" title="${msg("form.field.incomplete")}" /><span>
         </#if>
         <span class="viewmode-label">${field.label?html}:</span>
         <#if field.control.params.activateLinks?? && field.control.params.activateLinks == "true">
            <#assign fieldValue=field.value?html?replace("((http|ftp|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?\\^=%&:\\/~\\+#]*[\\w\\-\\@?\\^=%&\\/~\\+#])?)", "<a href=\"$1\" target=\"_blank\">$1</a>", "r")>
         <#else>
            <#assign fieldValue=field.value?html>
         </#if>
         <span class="viewmode-value"><#if fieldValue == "">${msg("form.control.novalue")}<#else>${fieldValue}</#if></span>
      </div>
   <#else>
      <label for="${fieldHtmlId}">${field.label?html}:<#if field.mandatory><span class="mandatory-indicator">${msg("form.required.fields.marker")}</span></#if></label>
      <textarea id="${fieldHtmlId}" name="${field.name}" rows="${rows!5}" cols="${columns!25}" tabindex="0"
                <#if field.description??>title="${field.description}"</#if>
                <#if field.control.params.styleClass??>class="${field.control.params.styleClass}"</#if>
                <#if field.control.params.style??>style="${field.control.params.style}"</#if>
                <#if field.disabled && !(field.control.params.forceEditable?? && field.control.params.forceEditable == "true")>disabled="true"</#if>>${field.value?html}</textarea>
      <@formLib.renderFieldHelp field=field />
   </#if>
<#-- commented out due to ALF-16153 -->
    <#--if form.mode == "edit">
    	<script type="text/javascript">//<![CDATA[
      (function()
      {
         new Alfresco.RichTextControl("${fieldHtmlId}").setOptions(
         {
            <#if form.mode == "view" || (field.disabled && !(field.control.params.forceEditable?? && field.control.params.forceEditable == "true"))>disabled: true,</#if>
            currentValue: "${field.value?js_string}",
            mandatory: ${field.mandatory?string},
            <@editorParameters field />
         }).setMessages(
            ${messages}
         );
      })();
      //]]></script>
    
    </#if-->
		   <script type="text/javascript">//<![CDATA[
		   new Alfresco.CommentsControls("${fieldHtmlId}-list").setOptions(
		   {
		      height: ${args.editorHeight!180},
		      width: ${args.editorWidth!700},
		      <#if context.properties.nodeRef??>
		         	itemNodeRef: "${context.properties.nodeRef?js_string}"
		         <#elseif (form.mode == "edit" || form.mode == "view") && args.itemId??>
		         	itemNodeRef: "${args.itemId?js_string}"
		         <#else>
		         	itemNodeRef: ""
		         </#if>
		   }).setMessages(
		      ${messages}
		   );
		//]]></script>
		   
		   <label for="${fieldHtmlId}">${field.label?html}:<#if field.mandatory><span class="mandatory-indicator">${msg("form.required.fields.marker")}</span></#if></label>
<#-- commented out due to ALF-16153 -->
		   
		    <#--if form.mode == "edit">
		   		<textarea id="${fieldHtmlId}" name="${field.name}" rows="${rows!5}" columns="${columns!25}" tabindex="0"
                <#if field.description??>title="${field.description}"</#if>
                <#if field.control.params.styleClass??>class="${field.control.params.styleClass}"</#if>
                <#if field.control.params.style??>style="${field.control.params.style}"</#if>
                <#if field.disabled && !(field.control.params.forceEditable?? && field.control.params.forceEditable == "true")>disabled="true"</#if>>${field.value?html}</textarea>
		   </#if-->
		   <div id="${fieldHtmlId}-list" class="comment-list" style="display:none;">
			   <div class="postlist-infobar">
			      <div id="${fieldHtmlId}-list-paginator" class="paginator"></div>
			   </div>
			   <div class="clear"></div>
			   <div id="${fieldHtmlId}-list-comments"></div>
			</div>
</div>
</#if> 