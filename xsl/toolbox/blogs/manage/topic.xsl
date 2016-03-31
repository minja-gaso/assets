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
			<input type="hidden" name="SCREEN" value="TOPIC" />
			<input type="hidden" name="BLOG_ID" value="{id}" />
			<input type="hidden" name="TOPIC_ID" value="{topic/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="event_content_navigation">
					<xsl:with-param name="SCREEN" select="'TOPIC'" />
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
			<script src="/js/view/calendar_event_general.js">//</script>
			<script>
				generateTimeOptions('TOPIC_PUBLISH_TIME', '<xsl:value-of select="$publishTime" />');

				$(document).ready(function(){
					$("#TOPIC_TAGS_LIST").tagit({
						fieldName: 'TOPIC_TAGS',
						removeConfirmation: true,
						allowSpaces: true
					});
					$("#TOPIC_PUBLISH_DATE").datepicker({
						changeMonth: true,
						changeYear: true,
						dateFormat: "mm-dd-yy",
						onSelect: function(selected){
							 $("#TOPIC_END_DATE").datepicker("option","minDate", selected)
						}
					}).datepicker("setDate", new Date("<xsl:value-of select="$publishDate" />"));
				});
			</script>
		</form>
	</xsl:template>
	<xsl:template name="main">
		<xsl:apply-templates select="topic" />
	</xsl:template>
	<xsl:template match="topic">
		<div class="form-group">
			<strong class="label">Published</strong>
			<div class="form-inline">
				<label class="inline">
					<input type="radio" name="TOPIC_PUBLISHED" id="TOPIC_PUBLISHED_TRUE" value="true">
						<xsl:if test="published = 'true'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>
					</input>&#160;<xsl:text>Yes</xsl:text>
				</label>
				<label class="inline">
					<input type="radio" name="TOPIC_PUBLISHED" id="TOPIC_PUBLISHED_FALSE" value="false">
						<xsl:if test="published = 'false'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>
					</input>&#160;<xsl:text>No</xsl:text>
				</label>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">General</div>
			<div class="panel-body">
				<div class="form-group">
					<label for="TOPIC_TITLE">Title <span class="required">*</span></label>
					<input type="text" class="form-control" name="TOPIC_TITLE" id="TOPIC_TITLE" value="{title}" />
				</div>
				<xsl:if test="eventRecurrence/recurring = 'true' or parentId > 0">
					<div class="form-group">
						<label for="TOPIC_TITLE_RECURRING_LABEL">Recurring Label</label>
						<input type="text" class="form-control" name="TOPIC_TITLE_RECURRING_LABEL" id="TOPIC_TITLE_RECURRING_LABEL" value="{titleRecurringLabel}" />
					</div>
				</xsl:if>
				<div class="row">
					<div class="form-group col-lg-2 col-md-3 col-sm-3">
						<label for="TOPIC_PUBLISH_DATE">Date <span class="required">*</span></label>
						<input type="text" class="form-control datepicker" name="TOPIC_PUBLISH_DATE" id="TOPIC_PUBLISH_DATE" value="{$publishDate}" />
					</div>
					<div class="form-group col-lg-2 col-md-3 col-sm-3">
						<label for="TOPIC_PUBLISH_TIME">Time <span class="required">*</span></label>
						<select class="form-control" name="TOPIC_PUBLISH_TIME" id="TOPIC_PUBLISH_TIME">
							<option />
						</select>
					</div>
					<div class="form-group col-xs-12">
						<label for="TOPIC_SUMMARY">Description <span class="required">*</span></label>
						<p class="help-block">Provide a summary for the event.</p>
						<input type="hidden" name="TOPIC_SUMMARY" id="TOPIC_SUMMARY" value="{summary}" />
						<trix-editor input="TOPIC_SUMMARY"></trix-editor>
					</div>
				</div>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading"><span class="fa fa-plus-square fa-lg">&#160;</span> Miscellaneous</div>
			<div class="panel-body">
				<div class="form-group">
					<label for="TOPIC_TAGS">Tags</label>
					<p class="help-block">Press <em>comma</em> to add new tag.  Tags can be comprised of multiple words.</p>
					<ul id="TOPIC_TAGS_LIST">
						<xsl:for-each select="tag">
							<li><xsl:value-of select="label" /></li>
						</xsl:for-each>
					</ul>
				</div>
				<xsl:if test="count(../category) &gt; 0">
					<xsl:variable name="categoryId" select="categoryId" />
					<div class="form-group">
						<label for="TOPIC_CATEGORY">Category</label>
						<div class="styled-select">
							<select class="form-control" id="TOPIC_CATEGORY" name="TOPIC_CATEGORY">
								<option value="0" />
								<xsl:for-each select="/data/blog/category">
									<option value="{id}">
										<xsl:if test="$categoryId = id">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										<xsl:value-of select="label" />
									</option>
								</xsl:for-each>
							</select>
						</div>
					</div>
				</xsl:if>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
