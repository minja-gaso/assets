<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />
	<xsl:include href="../../global_util.xsl" />
	<xsl:include href="../includes/blog_variables.xsl" />
	<xsl:include href="../includes/blog_nav.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<xsl:apply-templates select="blog" />
	</xsl:template>
	<xsl:template match="blog">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="FILE_UPLOAD" />
			<input type="hidden" name="BLOG_ID" value="{id}" />
			<input type="hidden" name="TOPIC_ID" value="{topic/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="event_content_navigation">
					<xsl:with-param name="SCREEN" select="'FILE_UPLOAD'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<h2>Add File(s)</h2>
				<p>Uploaded Files: <xsl:value-of select="count(topic/file)" /></p>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
			</div>
		</form>
	</xsl:template>
	<xsl:template name="main">
		<xsl:variable name="parentId" select="/data/event/calendar/parentId" />
		<xsl:choose>
			<xsl:when test="string-length(/data/calendar/event/fileName) &gt; 0">
				<div class="form-group">
					<label for="EVENT_HEADER">
						Uploaded Image
						<xsl:if test="string-length(/data/calendar/event/fileName) &gt; 0">
							<a class="label label-primary" onclick="javascript:deleteEventImage();submitForm();">Delete Image</a>
						</xsl:if>
					</label>
					<div>
						<img src="/uploads/calendar/{/data/calendar/id}/{/data/calendar/event/id}/{/data/calendar/event/fileName}"
							class="img-thumbnail img-responsive"
							alt="{/data/calendar/event/fileDescription}" />
					</div>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="form-group">
					<button class="btn btn-primary my_popup_open">Upload Image</button>
					<script src="/js/resources/jquery.popupoverlay.js">//</script>
					<script>
						$(document).ready(function() {
							$('#my_popup').popup({
								type: 'overlay',
								color: '#f7f7f7',
								opacity: 1,
								transition: '0.3s',
								scrolllock: true
							});
						});
					</script>
				</div>
			</xsl:otherwise>
		</xsl:choose>
		<div id="my_popup" class="sr-only">
			<iframe class="embed-responsive-item" src="/toolbox/blogFileUploadServlet?BLOG_ID={id}&amp;TOPIC_ID={topic/id}"></iframe>
			<hr/>
			<button class="btn btn-danger my_popup_close" id="my_popup_close">Close Upload</button>
			<button class="sr-only" id="uploaded"></button>
			<script>
				var uploaded = document.getElementById('uploaded');
				uploaded.addEventListener('click', function(){
					setTimeout(function(){
						document.portal_form.submit();
					}, 1000);
				})
			</script>
		</div>
		<xsl:apply-templates select="topic" />
	</xsl:template>
	<xsl:template match="topic">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th class="col-xs-2 text-center">Image</th>
					<th class="col-xs-2 text-center">Type</th>
					<th class="col-xs-8">Description</th>
				</tr>
			</thead>
			<tbody>
				<xsl:apply-templates select="file" />
			</tbody>
		</table>
	</xsl:template>
	<xsl:template match="file">
		<tr>
			<th>
				<img src="{concat('/uploads/blog/', /data/blog/id, '/', /data/blog/topic/id, '/', name)}" style="max-width:150px;" />
				<p><xsl:value-of select="name" /></p>
			</th>
			<td class="text-center"><xsl:value-of select="type" /></td>
			<td><xsl:value-of select="description" /></td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
