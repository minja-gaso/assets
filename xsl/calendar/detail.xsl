<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />
	<xsl:variable name="apos">'</xsl:variable>

	<xsl:import href="includes/calendar_global.xsl" />
	<xsl:import href="includes/calendar_date_time.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form" id="public-form">
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="CALENDAR_ID" value="{/data/calendar/id}" />
			<input type="hidden" name="POST_FORM" value="false" />
	    <link href="/css/main.css" rel="stylesheet"/>
			<h1 class="form-group"><xsl:value-of select="/data/calendar/title" /></h1>
			<xsl:choose>
				<!-- if form not started -->
				<xsl:when test="/data/form/started = 'false'">
					<div class="form-message">
						<xsl:value-of select="/data/form/messageNotStarted" disable-output-escaping="yes" />
					</div>
				</xsl:when>
				<!-- if none of cases above are met, display the form -->
				<xsl:otherwise>
					<xsl:call-template name="public_calendar" />
					<script>
						$(document).ready(function(){
							$(".list-recurring .recurring-title").click(function(){
								$(this).parent().find(".recurring-agenda").toggle();
							});
						});
					</script>
				</xsl:otherwise>
			</xsl:choose>
			<footer class="text-center">Provided by <em><a href="#">Interactive Marketing</a></em> at <em><a href="#">Baylor Scott &amp; White</a></em></footer>
		</form>
	</xsl:template>


	<xsl:template name="public_calendar">
		<xsl:if test="string-length(/data/form/messagePublicFormIntro) &gt; 0">
			<div class="form-message form-intro">
				<xsl:value-of select="/data/form/messagePublicFormIntro" disable-output-escaping="yes" />
			</div>
		</xsl:if>
    <ol class="breadcrumb">
      <li><a href="/calendar/list/{/data/calendar/id}">Home</a></li>
      <li class="active"><xsl:value-of select="/data/calendar/event/title" /></li>
    </ol>
		<div class="row">
			<div class="col-lg-3 col-md-3 col-sm-3">
				<xsl:call-template name="sidebar" />
			</div>
			<div class="col-lg-9 col-md-9 col-sm-9">
				<xsl:call-template name="main" />
			</div>
		</div>

		<xsl:if test="string-length(/data/form/messagePublicFormClosing) &gt; 0">
			<div class="form-message form-closing">
				<xsl:value-of select="/data/form/messagePublicFormClosing" disable-output-escaping="yes" />
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template name="main">
		<xsl:for-each select="/data/calendar/event[position() = 1]">
			<xsl:variable name="eventId" select="id" />
			<xsl:variable name="fileName" select="fileName" />
			<xsl:variable name="parentId" select="parentId" />
			<ul class="list-inline">
				<li>
					<a class="btn btn-social-icon btn-twitter">
						<span class="fa fa-twitter"></span>
					</a>
				</li>
				<li>
					<a class="btn btn-social-icon btn-facebook">
						<span class="fa fa-facebook"></span>
					</a>
				</li>
				<li>
					<a class="btn btn-social-icon btn-linkedin">
						<span class="fa fa-linkedin"></span>
					</a>
				</li>
				<li>
					<a class="btn btn-social-icon btn-google">
						<span class="fa fa-google"></span>
					</a>
				</li>
				<li>
					<a class="btn btn-social-icon btn-pinterest">
						<span class="fa fa-pinterest"></span>
					</a>
				</li>
				<li>
					<a class="btn btn-social-icon btn-flickr">
						<span class="fa fa-envelope"></span>
					</a>
				</li>
			</ul>
			<!--
			<ul class="sm-icons list-inline" id="share-icons">
				<li><strong>Share with:</strong></li>
				<li>
					<a target="_blank" href="http://www.facebook.com/bswhealth" title="Click on the icon to go to the Baylor Scott &amp; White Health Facebook page">
						<img alt="" src="http://sw.org/resources/images/icon/social/icon_facebook.jpg"/>
					</a>
				</li>
				<li>
					<a target="_blank" href="https://twitter.com/bswhealth" title="Click on the icon to go to the Baylor Scott &amp; White Health - Central Texas Twitter page">
						<img alt="" src="http://sw.org/resources/images/icon/social/icon_twitter.jpg"/>
					</a>
				</li>
				<li>
					<a target="_blank" href="https://plus.google.com/104130803433548643332/videos" title="Click on the icon to go to the Scott &amp; White Healthcare Google+ page">
						<img alt="" src="http://sw.org/resources/images/icon/social/icon_google.jpg"/>
					</a>
				</li>
				<li>
					<a target="_blank" href="https://www.pinterest.com/bswhealth/" title="Click on the icon to go to the Baylor Scott &amp; White Health Pintrest page">
						<img alt="" src="http://sw.org/resources/images/icon/social/icon_pinterest.jpg"/>
					</a>
				</li>
			</ul>
		-->
			<ul class="list-group">
				<li class="list-group-item event">
					<h2><xsl:value-of select="title" /></h2>
					<xsl:if test="count(tag) &gt; 0">
						<div class="form-group tags">
							<ul class="list-inline">
								<li>
									<a href="/calendar/search/{/data/calendar/prettyUrl}?type=category&amp;id={categoryId}">
										<span class="label label-primary">
											<xsl:variable name="categoryId" select="categoryId" />
											<span class="fa fa-archive" />&#160;<xsl:value-of select="/data/calendar/category[id = $categoryId]/label" />
										</span>
									</a>
								</li>
								<xsl:for-each select="tag">
									<li>
										<a href="/calendar/search/{/data/calendar/prettyUrl}?type=tag&amp;id={id}">
											<span class="label label-primary">
												<span class="fa fa-tag" />&#160;<xsl:value-of select="label" />
											</span>
										</a>
									</li>
								</xsl:for-each>
							</ul>
						</div>
					</xsl:if>
					<xsl:if test="string-length(fileName) &gt; 0">
						<xsl:variable name="fileDirectoryPath">
							<xsl:choose>
								<xsl:when test="parentId &gt; 0 and /data/calendar/event[id=$parentId]/fileName = $fileName">
									<xsl:value-of select="parentId" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="id" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<div class="thumbnail">
							<img src="/uploads/calendar/{/data/calendar/id}/{$fileDirectoryPath}/{fileName}" class="img-responsive" alt="Responsive image" onload="this.parentNode.style.width=this.offsetWidth + 'px'" />
					    <div class="caption">
					      <xsl:text><xsl:value-of select="fileDescription" /></xsl:text>
					    </div>
					  </div>
					</xsl:if>
					<xsl:if test="/data/calendar/event[0]/eventRecurrence/recurring = 'false'">
						<div class="row detail-item">
							<div class="col-lg-2 col-md-3 col-sm-3">
								<strong>Date</strong>
							</div>
							<div class="col-lg-10 col-md-9 col-sm-9">
								<xsl:call-template name="format_date">
									<xsl:with-param name="paramDate" select="startDate" />
								</xsl:call-template>
							</div>
						</div>
						<div class="row detail-item">
							<div class="col-lg-2 col-md-3 col-sm-3">
								<strong>Time</strong>
							</div>
							<div class="col-lg-10 col-md-9 col-sm-9">
								<xsl:call-template name="format_time">
									<xsl:with-param name="startTime" select="startTime" />
									<xsl:with-param name="endTime" select="endTime" />
								</xsl:call-template>
							</div>
						</div>
					</xsl:if>
					<xsl:if test="string-length(location) &gt; 0">
						<div class="row detail-item">
							<div class="col-lg-2 col-md-3 col-sm-3">
								<strong>Location</strong>
							</div>
							<div class="col-lg-10 col-md-9 col-sm-9">
								<xsl:value-of select="location" />
								<xsl:if test="string-length(locationAdditional) &gt; 0">
									<div class="location-additional">
										<xsl:value-of select="locationAdditional" />
									</div>
								</xsl:if>
							</div>
						</div>
					</xsl:if>
					<xsl:if test="string-length(description) &gt; 0">
						<div class="row detail-item">
							<div class="col-lg-2 col-md-3 col-sm-3">
								<strong>Description</strong>
							</div>
							<div class="col-lg-10 col-md-9 col-sm-9">
								<xsl:value-of select="description" disable-output-escaping="yes" />
							</div>
						</div>
					</xsl:if>
					<xsl:if test="string-length(contactName) &gt; 0">
						<div class="row detail-item">
							<div class="col-lg-2 col-md-3 col-sm-3">
								<strong>Contact Name</strong>
							</div>
							<div class="col-lg-10 col-md-9 col-sm-9">
								<xsl:value-of select="contactName" />
							</div>
						</div>
					</xsl:if>
					<xsl:if test="string-length(contactPhone) &gt; 0">
						<div class="row detail-item">
							<div class="col-lg-2 col-md-3 col-sm-3">
								<strong>Contact Phone</strong>
							</div>
							<div class="col-lg-10 col-md-9 col-sm-9">
								<a href="tel:{contactPhone}"><xsl:value-of select="contactPhone" /></a>
							</div>
						</div>
					</xsl:if>
					<xsl:if test="string-length(contactEmail) &gt; 0">
						<div class="row detail-item">
							<div class="col-lg-2 col-md-3 col-sm-3">
								<strong>Contact Email</strong>
							</div>
							<div class="col-lg-10 col-md-9 col-sm-9">
								<a href="mailto:{contactEmail}"><xsl:value-of select="contactEmail" /></a>
							</div>
						</div>
					</xsl:if>
					<xsl:if test="string-length(speaker) &gt; 0">
						<div class="row detail-item">
							<div class="col-lg-2 col-md-3 col-sm-3">
								<strong>Speaker</strong>
							</div>
							<div class="col-lg-10 col-md-9 col-sm-9">
								<xsl:value-of select="speaker" />
							</div>
						</div>
					</xsl:if>
					<xsl:if test="string-length(registrationUrl) &gt; 0">
						<div class="row detail-item">
							<div class="col-lg-2 col-md-3 col-sm-3">
								<strong>Registration</strong>
							</div>
							<div class="col-lg-10 col-md-9 col-sm-9">
								<a href="{registrationUrl}"><xsl:value-of select="registrationLabel" /></a>
							</div>
						</div>
					</xsl:if>
					<xsl:if test="string-length(cost) &gt; 0">
						<div class="row detail-item">
							<div class="col-lg-2 col-md-3 col-sm-3">
								<strong>Cost</strong>
							</div>
							<div class="col-lg-10 col-md-9 col-sm-9">
								<xsl:value-of select="cost" />
							</div>
						</div>
					</xsl:if>
					<xsl:if test="count(/data/calendar/event[parentId=$eventId]) &gt; 0 and parentId = 0">
						<div class="row detail-item">
							<div class="col-lg-2 col-md-3 col-sm-3">
								<strong>Recurring on</strong>
							</div>
							<div class="col-lg-10 col-md-9 col-sm-9">
								<ul class="list-unstyled list-recurring">
									<li id="{id}">
										<!--
										<a href="/calendar/detail/{/data/calendar/prettyUrl}?eventID={/data/calendar/event/id}">
											<xsl:choose>
												<xsl:when test="string-length(titleRecurringLabel) = 0">
													<xsl:call-template name="format_date">
														<xsl:with-param name="paramDate" select="startDate" />
													</xsl:call-template>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="titleRecurringLabel" />
												</xsl:otherwise>
											</xsl:choose>
										</a>
										-->
										<xsl:variable name="recurringTitleElementName">
											<xsl:choose>
												<xsl:when test="string-length(agenda) &gt; 0">a</xsl:when>
												<xsl:otherwise>div</xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<xsl:element name="{$recurringTitleElementName}">
											<xsl:attribute name="class">recurring-row recurring-title</xsl:attribute>
											<xsl:choose>
												<xsl:when test="string-length(titleRecurringLabel) &gt; 0">
													<xsl:value-of select="titleRecurringLabel" />
												</xsl:when>
												<xsl:otherwise>
													<!--
													<xsl:call-template name="format_date">
														<xsl:with-param name="paramDate" select="startDate" />
													</xsl:call-template>
												-->
													Day <xsl:value-of select="position()" />
												</xsl:otherwise>
											</xsl:choose>
										</xsl:element>
										<!--
										<xsl:if test="string-length(titleRecurringLabel) &gt; 0">
										-->
											<p class="recurring-row recurring-date">
												<xsl:call-template name="format_date">
													<xsl:with-param name="paramDate" select="startDate" />
												</xsl:call-template>
											</p>
										<!--
										</xsl:if>
										-->
										<p class="recurring-row recurring-time">
											<xsl:call-template name="format_time">
												<xsl:with-param name="paramDate" select="/data/calendar/event/startTime" />
											</xsl:call-template>
										</p>
										<xsl:if test="string-length(agenda) &gt; 0">
											<div class="recurring-row recurring-agenda" id="recurring-agenda-{id}">
												<strong>Agenda</strong>
												<xsl:value-of select="agenda" disable-output-escaping="yes" />
											</div>
										</xsl:if>
									</li>
									<xsl:for-each select="/data/calendar/event[parentId=$eventId]">
										<li id="{id}">
											<xsl:variable name="recurringTitleElementName">
												<xsl:choose>
													<xsl:when test="string-length(agenda) &gt; 0">a</xsl:when>
													<xsl:otherwise>div</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<xsl:element name="{$recurringTitleElementName}">
												<xsl:attribute name="class">recurring-row recurring-title</xsl:attribute>
												<xsl:choose>
													<xsl:when test="string-length(titleRecurringLabel) &gt; 0">
														<xsl:value-of select="titleRecurringLabel" />
													</xsl:when>
													<xsl:otherwise>
														<!--
														<xsl:call-template name="format_date">
															<xsl:with-param name="paramDate" select="startDate" />
														</xsl:call-template>
													-->
														Instance <xsl:value-of select="position() + 1" />
													</xsl:otherwise>
												</xsl:choose>
											</xsl:element>
											<!--
											<xsl:if test="string-length(titleRecurringLabel) &gt; 0">
											-->
												<p class="recurring-row recurring-date">
													<xsl:call-template name="format_date">
														<xsl:with-param name="paramDate" select="startDate" />
													</xsl:call-template>
												</p>
											<!--
											</xsl:if>
											-->
											<p class="recurring-row recurring-time">
												<xsl:call-template name="format_time">
													<xsl:with-param name="paramDate" select="/data/calendar/event/startTime" />
												</xsl:call-template>
											</p>
											<xsl:if test="string-length(agenda) &gt; 0">
												<div class="recurring-row recurring-agenda" id="recurring-agenda-{id}">
													<strong>Agenda</strong>
													<xsl:value-of select="agenda" disable-output-escaping="yes" />
												</div>
											</xsl:if>
										</li>
									</xsl:for-each>
								</ul>
							</div>
						</div>
					</xsl:if>
					<xsl:if test="number(parentId) &gt; 0">
						<div class="row detail-item text-info">
							<div class="col-lg-2 col-md-3 col-sm-3">
								<strong>Original Date</strong>
							</div>
							<div class="col-lg-10 col-md-9 col-sm-9">
								<a href="/calendar/detail/{/data/calendar/prettyUrl}?eventID={parentId}">
									<xsl:call-template name="format_date">
										<xsl:with-param name="paramDate" select="/data/calendar/event[parentId = 0]/startDate" />
									</xsl:call-template>
								</a>
							</div>
						</div>
					</xsl:if>
				</li>
			</ul>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
