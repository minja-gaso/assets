<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
			<input type="hidden" name="SCREEN" value="ARTICLE" />
			<input type="hidden" name="BLOG_ID" value="{id}" />
			<input type="hidden" name="TOPIC_ID" value="{topic/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="event_content_navigation">
					<xsl:with-param name="SCREEN" select="'ARTICLE'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<div class="form-group" id="top-actions">
					<div class="btn-toolbar">
						<button class="btn btn-default" onclick="saveTopic();submitForm();">Save</button>
						<button class="btn btn-default" onclick="topics();submitForm();">Back to Topics</button>
						<a class="btn btn-default" href="{$listUrl}" target="_blank">View Blog</a>
						<a class="btn btn-default" href="{$topicUrl}" target="_blank">View Topic</a>
					</div>
				</div>
				<h2>Edit Topic</h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="form-row">
					<div class="btn-toolbar">
						<button class="btn btn-default" onclick="saveTopic();submitForm();">Save</button>
						<button class="btn btn-default" onclick="topics();submitForm();">Back to Topics</button>
						<a class="btn btn-default" href="{$listUrl}" target="_blank">View Blog</a>
						<a class="btn btn-default" href="{$topicUrl}" target="_blank">View Topic</a>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="main">
		<xsl:apply-templates select="topic" />
	</xsl:template>
	<xsl:template match="topic">
		<div class="form-group">
			<label for="TOPIC_ARTICLE">Article - <xsl:value-of select="count(file[type='embedded'])" /></label>
			<p class="help-block">Enter the full article here.</p>
			<input type="hidden" name="TOPIC_ARTICLE" id="TOPIC_ARTICLE" value="{article}" />
			<textarea name="TOPIC_ARTICLE">abc</textarea>
			<script>
				tinymce.init({
  selector: 'textarea',
  height: 500,
  plugins: [
    'advlist autolink lists link image charmap print preview anchor',
    'searchreplace visualblocks code fullscreen',
    'insertdatetime media table contextmenu paste code noneditable'
  ],
  toolbar: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image embedded_images',
	setup: function(editor) {
    editor.addButton('embedded_images', {
      type: 'menubutton',
      text: 'Embedded Images',
      icon: false,
      menu: [
				<xsl:for-each select="file[type='embedded']">
					<xsl:variable name="imageSrc" select="concat('/uploads/blog/', /data/blog/id, '/', /data/blog/topic/id, '/', name)" />
					<xsl:variable name="imageHtml">
						<div id="embed-grouping-{position()}">
							<div class="mceNonEditable">
								<figure>
									<a href="{$imageSrc}">
										<img src="{$imageSrc}" id="embed-grouping-{position()}-image" />
									</a>
								</figure>
								<figcaption><xsl:value-of select="description" /></figcaption>
							</div>
						</div>
					</xsl:variable>
					{
            classes: 'embedded-image-item',
						image: '<xsl:value-of select="$imageSrc" />',
						onclick: function()
						{
								editor.execCommand('mceInsertContent', false, '<xsl:copy-of select="$imageHtml" />');
								var content = editor.getContent();
								var parentDiv = document.createElement('div');
								parentDiv.innerHTML = content;
								var imgWidth = parentDiv.querySelector('img').naturalWidth;
								parentDiv.querySelector('#embed-grouping-<xsl:value-of select="position()" />').style.maxWidth = imgWidth + 'px';
								editor.setContent(parentDiv.innerHTML);
						}
					}<xsl:if test="position() != last()">,</xsl:if>
				</xsl:for-each>
			]
    });
  },
	content_css: [
    '//fast.fonts.net/cssapi/e6dc9b99-64fe-4292-ad98-6974f93cd2a2.css',
    '//www.tinymce.com/css/codepen.min.css'
  ]
});
			</script>
		</div>
	</xsl:template>
</xsl:stylesheet>
