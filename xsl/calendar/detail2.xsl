<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />

	<xsl:import href="includes/calendar_global.xsl" />
	<xsl:import href="includes/calendar_date_time.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<xsl:apply-templates select="calendar" />
	</xsl:template>
	<xsl:template match="calendar">
		<form action="" method="get" name="portal_form" id="bswh-marketing">
			<div id="bswh">
				<input type="hidden" name="searchType" value="keyword" />
				<xsl:call-template name="external_files" />
		    <link href="/css/public/calendar.css" rel="stylesheet"/>
				<xsl:call-template name="public_calendar" />
				<script>
					$(document).ready(function(){
						$(".list-recurring .recurring-title").click(function(){
							$(this).parent().find(".recurring-agenda").toggle();
						});
					});
				</script>
			</div>
		</form>
	</xsl:template>

	<xsl:template name="public_calendar">
		<xsl:if test="string-length(/data/form/messagePublicFormIntro) &gt; 0">
			<div class="form-message form-intro">
				<xsl:value-of select="/data/form/messagePublicFormIntro" disable-output-escaping="yes" />
			</div>
		</xsl:if>
		<!--
    <ol class="breadcrumb">
      <li><a href="/calendar/list/{/data/calendar/id}">Home</a></li>
      <li class="active"><xsl:value-of select="/data/calendar/event/title" /></li>
    </ol>
		-->
		<div class="row" id="cal-main">
			<!--
			<div class="col-lg-3 col-md-3 col-sm-3">
				<xsl:call-template name="sidebar" />
			</div>
			-->
			<div class="col-lg-12 col-md-12 col-sm-12">
				<xsl:call-template name="breadcrumb"/>
				<h1 class="form-group"><xsl:value-of select="title" /></h1>
				<xsl:call-template name="main" />
				<footer class="text-center">Provided by <em><a href="#">Interactive Marketing</a></em> at <em><a href="#">Baylor Scott &amp; White</a></em></footer>
			</div>
		</div>

		<xsl:if test="string-length(/data/form/messagePublicFormClosing) &gt; 0">
			<div class="form-message form-closing">
				<xsl:value-of select="/data/form/messagePublicFormClosing" disable-output-escaping="yes" />
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template name="main">
		<xsl:call-template name="top_nav" />
		<xsl:for-each select="event[position() = 1]">
			<xsl:variable name="eventId" select="id" />
			<xsl:variable name="fileName" select="fileName" />
			<xsl:variable name="parentId" select="parentId" />
			<ul class="list-group" id="event-item">
				<li class="list-group-item event">
					<!--
					<div class="calendar-navigate">
						<a href="/calendar/list/{../prettyUrl}">
							<span class="fa fa-arrow-circle-o-left" /> All Events
						</a>
					</div>
				-->
					<h2><xsl:value-of select="title" /></h2>
					<p>
						<xsl:call-template name="format_date">
							<xsl:with-param name="paramDate" select="startDate" />
						</xsl:call-template>
						<xsl:text>&#160;@&#160;</xsl:text>
						<xsl:call-template name="format_time">
							<xsl:with-param name="startTime" select="startTime" />
							<xsl:with-param name="endTime" select="endTime" />
						</xsl:call-template>
					</p>
					<xsl:if test="string-length(fileName) &gt; 0">
						<xsl:variable name="fileDirectoryPath">
							<xsl:choose>
								<xsl:when test="parentId &gt; 0 and event[id=$parentId]/fileName = $fileName">
									<xsl:value-of select="parentId" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="id" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<div class="thumbnail">
							<img src="/uploads/calendar/{../id}/{$fileDirectoryPath}/{fileName}" class="img-responsive" alt="Responsive image" onload="this.parentNode.style.width=this.offsetWidth + 'px'" />
							<caption><xsl:value-of select="fileDescription" /></caption>
						</div>
						<!--
						<div class="thumbnail">
							<img src="/uploads/calendar/{/data/calendar/id}/{$fileDirectoryPath}/{fileName}" class="img-responsive" alt="Responsive image" onload="this.parentNode.style.width=this.offsetWidth + 'px'" />
					    <div class="caption">
					      <xsl:text><xsl:value-of select="fileDescription" /></xsl:text>
					    </div>
					  </div>
						-->
					</xsl:if>
					<div class="row detail-item" id="event-description">
						<div class="col-xs-12">
							<xsl:value-of select="description" disable-output-escaping="yes" />
						</div>
					</div>
					<div class="row detail-item event-block" id="event-information">
						<div class="col-sm-4 col-xs-12">
							<h3>Details</h3>
							<ul class="list-unstyled">
								<li>
									<strong>Date</strong>
									<div>
										<xsl:call-template name="format_date">
											<xsl:with-param name="paramDate" select="startDate" />
										</xsl:call-template>
									</div>
								</li>
								<li>
									<strong>Time</strong>
									<div>
										<xsl:call-template name="format_time">
											<xsl:with-param name="startTime" select="startTime" />
											<xsl:with-param name="endTime" select="endTime" />
										</xsl:call-template>
									</div>
								</li>
								<xsl:if test="categoryId &gt; 0">
									<li>
										<strong>Event Category</strong>
										<div>
											<a href="/calendar/search/{../prettyUrl}?type=category&amp;id={categoryId}">
												<xsl:variable name="categoryId" select="categoryId" />
												<xsl:value-of select="../category[id = $categoryId]/label" />
											</a>
										</div>
									</li>
								</xsl:if>
								<xsl:if test="count(tag) &gt; 0">
									<li>
										<strong>Event Tags</strong>
										<div>
											<xsl:for-each select="tag">
												<a href="/calendar/search/{../prettyUrl}?searchType=tag&amp;tagId={id}">
													<xsl:value-of select="label" />
												</a>
												<xsl:if test="position() != last()">,&#160;</xsl:if>
											</xsl:for-each>
										</div>
									</li>
								</xsl:if>
							</ul>
						</div>
						<xsl:if test="string-length(contactName) &gt; 0 or string-length(contactPhone) &gt; 0 or string-length(contactEmail) &gt; 0">
							<div class="col-sm-4 col-xs-12">
								<h3>Organizer</h3>
								<ul class="list-unstyled">
									<xsl:if test="string-length(contactName) &gt; 0">
										<li>
											<strong>Contact Name</strong>
											<div>
												<xsl:value-of select="contactName" />
											</div>
										</li>
									</xsl:if>
									<xsl:if test="string-length(contactPhone) &gt; 0">
										<li>
											<strong>Contact Phone</strong>
											<div>
												<a href="tel:{contactPhone}"><xsl:value-of select="contactPhone" /></a>
											</div>
										</li>
									</xsl:if>
									<xsl:if test="string-length(contactEmail) &gt; 0">
										<li>
											<strong>Contact Email</strong>
											<div>
												<a href="mailto:{contactEmail}"><xsl:value-of select="contactEmail" /></a>
											</div>
										</li>
									</xsl:if>
								</ul>
							</div>
						</xsl:if>
						<xsl:if test="string-length(speaker) &gt; 0 or string-length(registrationUrl) &gt; 0 or string-length(cost) &gt; 0">
							<div class="col-sm-4 col-xs-12">
								<h3>Other</h3>
								<ul class="list-unstyled">
									<xsl:if test="string-length(speaker) &gt; 0">
										<li>
											<strong>Speaker(s)</strong>
											<div>
												<xsl:value-of select="speaker" />
											</div>
										</li>
									</xsl:if>
									<xsl:if test="string-length(registrationUrl) &gt; 0">
										<li>
											<strong>Registration</strong>
											<div>
												<a href="{registrationUrl}"><xsl:value-of select="registrationLabel" /></a>
											</div>
										</li>
									</xsl:if>
									<xsl:if test="string-length(cost) &gt; 0">
										<li>
											<strong>Cost</strong>
											<div>
												<xsl:value-of select="cost" />
											</div>
										</li>
									</xsl:if>
								</ul>
							</div>
						</xsl:if>
					</div>
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

					<div class="row event-detail event-block" id="venue">
						<xsl:variable name="locationAddress">
							<xsl:choose>
								<xsl:when test="location = 'Scott &amp; White Memorial Hospital - Temple'">2401 S. 31st Street, Temple, TX 76508</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<style type="text/css">
				      html, body { height: 100%; margin: 0; padding: 0; }
				      #map { border: 12px solid #ffffff; height: 250px; max-width: 600px; min-height: 250px; padding-left: 0; }
				    </style>
						<div class="col-sm-4" id="location-info">
							<h3>Venue</h3>
							<p><xsl:value-of select="location" /></p>
							<p><xsl:value-of select="locationAdditional" disable-output-escaping="yes" /></p>
							<!--
							<h4>Contact Us</h4>
							<p>Phone: 254-724-2111</p>
							<p>Toll Free: 800-792-3710</p>
							-->
							<p><span class="fa fa-map-marker" />&#160;<a href="https://www.google.com/maps/place/{$locationAddress}">Google Maps</a></p>
						</div>
						<div class="col-sm-8" id="map"></div>
						<script type="text/javascript">
							<xsl:variable name="locationAddress">
								<xsl:choose>
									<xsl:when test="location = 'Scott &amp; White Memorial Hospital - Temple'">2401 S. 31st Street, Temple, TX 76508</xsl:when>
								</xsl:choose>
							</xsl:variable>
							function initMap() {
							  var map = new google.maps.Map(document.getElementById('map'), {
							    center: {lat: 31.0776722, lng: -97.36398550000001},
							    zoom: 14
							  });
  							var geocoder = new google.maps.Geocoder();

								window.onload = function(){
									geocodeAddress(geocoder, map);
								}
							}
							function geocodeAddress(geocoder, resultsMap) {
							  var address = '<xsl:value-of select="$locationAddress" />';
							  geocoder.geocode({'address': address}, function(results, status) {
							    if (status === google.maps.GeocoderStatus.OK) {
							      resultsMap.setCenter(results[0].geometry.location);
							      var marker = new google.maps.Marker({
							        map: resultsMap,
							        position: results[0].geometry.location
							      });
							    } else {
							      console.log('Geocode was not successful for the following reason: ' + status);
							    }
							  });
							}
						</script>
						<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCMyFwsdDQByebGig-c4DZMXJHe3UYhZU4&amp;callback=initMap" async="async" defer="defer">//</script>
					</div>

					<xsl:if test="count(/data/calendar/event[parentId=$eventId]) &gt; 0 and parentId = 0">
						<div class="row detail-item">
							<div class="col-xs-12">
								<h3>Repeating Event</h3>
								<ol class="list-recurring">
									<xsl:apply-templates select="." />
								</ol>
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
	<xsl:template match="event">
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
			<xsl:if test="string-length(titleRecurringLabel) &gt; 0">
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
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
				<!--
				<xsl:if test="string-length(titleRecurringLabel) &gt; 0">
				-->
					<div class="recurring-row recurring-date">
						<xsl:call-template name="format_date">
							<xsl:with-param name="paramDate" select="startDate" />
						</xsl:call-template>
					</div>
				<!--
				</xsl:if>
				-->
				<div class="recurring-row recurring-time">
					<xsl:call-template name="format_time">
						<xsl:with-param name="paramDate" select="/data/calendar/event/startTime" />
					</xsl:call-template>
				</div>
				<xsl:if test="string-length(agenda) &gt; 0">
					<div class="recurring-row recurring-agenda" id="recurring-agenda-{id}">
						<strong>Agenda</strong>
						<xsl:value-of select="agenda" disable-output-escaping="yes" />
					</div>
				</xsl:if>
			</xsl:if>
		</li>
	</xsl:template>
</xsl:stylesheet>
