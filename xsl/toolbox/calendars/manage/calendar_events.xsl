<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../../global_util.xsl" />
	<xsl:include href="../includes/calendar_variables.xsl" />
	<xsl:include href="../includes/calendar_nav.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="EVENTS" />
			<input type="hidden" name="CALENDAR_ID" value="{/data/calendar/id}" />
			<input type="hidden" name="EVENT_ID" />
			<!-- survey content -->
			<div class="row">
				<nav>
					<xsl:call-template name="primary_content_navigation">
						<xsl:with-param name="SCREEN" select="'EVENTS'" />
					</xsl:call-template>
				</nav>
				<div class="col-lg-12 bordered-area">
					<h2>Events for <em><xsl:value-of select="/data/calendar/title" /></em></h2>
					<nav id="wizard">
						<h3>Quick Jumps</h3>
						<ul>
							<li>
								<a class="selected done" href="javascript:document.portal_form.COMPONENT_ID.value='3';switchTab('GENERAL');submitForm();" title="current page">
									<span class="stepNumber">1</span>
									<span class="stepDesc text-small">Provide basic info</span>
								</a>
							</li>
							<li>
								<a class="selected done" href="javascript:document.portal_form.COMPONENT_ID.value='3';switchTab('ROLES');submitForm();">
									<span class="stepNumber">2</span>
									<span class="stepDesc text-small">Assign access for other users</span>
								</a>
							</li>
							<li>
								<a class="selected" href="javascript:void(0);">
									<span class="stepNumber">3</span>
									<span class="stepDesc text-small">Start adding events</span>
								</a>
							</li>
						</ul>
					</nav>
					<xsl:if test="count(/data/calendar/category) = 0">
						<div class="alert alert-info"><span class="fa fa-info-circle fa-lg">&#160;</span> Consider adding categories to better identify the type of event.</div>
					</xsl:if>
					<xsl:call-template name="messages" />
    			<div class="form-group btn-group pull-right">
    				<a class="btn btn-primary btn-lg" href="javascript:createEvent();submitForm();"><span class="fa fa-calendar fa-lg"><span class="hide">Add New Event</span></span> Add New Event</a>
    			</div>
					<script>
						$(document).ready(function(){
							$('.clickable').click(function(){
								var id = $(this).attr('id');
								var target = $('.collapsed-' + id);
								var toggle = $('.toggle-' + id);

								$(target).each(function(){
									$(this).toggle();
								});

								$(toggle).toggleClass('fa-minus');
							});
						});
					</script>
					<table class="table table-condensed">
						<thead>
							<tr>
								<th class="col-lg-1 col-md-1 col-sm-1 text-center">&#160;</th>
								<th class="col-lg-1 col-md-2 col-sm-2 text-center">Start Date</th>
								<!--<th class="col-lg-1 col-md-1 col-sm-2 text-center">End Date</th>-->
								<th class="col-lg-1 col-md-1 col-sm-2 text-center">Published</th>
								<th class="col-lg-6 col-md-6 col-sm-6">Title</th>
								<th class="col-lg-1 col-md-1 col-sm-2 text-center">Delete</th>
								<th class="col-lg-1 col-md-1 col-sm-2 text-center">View</th>
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="/data/calendar/event[parentId=0]">
								<xsl:variable name="id" select="id" />
								<tr class="event-row clickable" id="{$id}" data-target="collapsed-{$id}">
									<th class="text-center">
										<xsl:choose>
											<xsl:when test="count(/data/calendar/event[parentId=$id]) &gt; 0">
												<span class="toggle-{$id} fa fa-plus" />
											</xsl:when>
											<xsl:otherwise>&#160;</xsl:otherwise>
										</xsl:choose>
									</th>
									<td class="text-center">
										<xsl:variable name="startDate">
											<xsl:variable name="year" select="substring(startDate, 1, 4)" />
											<xsl:variable name="month" select="substring(startDate, 6, 2)" />
											<xsl:variable name="day" select="substring(startDate, 9, 2)" />
											<xsl:value-of select="concat($month, '/', $day, '/', $year)" />
										</xsl:variable>
										<xsl:value-of select="$startDate" />
									</td>
									<!--
									<td class="text-center">
										<xsl:variable name="endDate">
											<xsl:variable name="year" select="substring(endDate, 1, 4)" />
											<xsl:variable name="month" select="substring(endDate, 6, 2)" />
											<xsl:variable name="day" select="substring(endDate, 9, 2)" />
											<xsl:value-of select="concat($month, '/', $day, '/', $year)" />
										</xsl:variable>
										<xsl:value-of select="$endDate" />
									</td>
								-->
									<td class="text-center">
										<span>
											<xsl:attribute name="class">
												<xsl:choose>
													<xsl:when test="published = 'true'">fa fa-check</xsl:when>
													<xsl:otherwise>fa fa-close</xsl:otherwise>
												</xsl:choose>
											</xsl:attribute>
										</span>
									</td>
									<td>
										<a href="javascript:editEvent('{id}');submitForm();">
											<xsl:attribute name="href">
												<xsl:choose>
													<xsl:when test="parentId &gt; 0">
														<xsl:value-of select="concat('javascript:editNotify(', $quote, parentId, $quote, ',', $quote, id, $quote, ')')" />
													</xsl:when>
													<xsl:otherwise>
															<xsl:value-of select="concat('javascript:editEvent(', $quote, id, $quote, ');submitForm();')" />
													</xsl:otherwise>
												</xsl:choose>
											</xsl:attribute>
                      <xsl:choose>
                        <xsl:when test="string-length(title) &gt; 0">
                          <span>
                            <xsl:text><xsl:value-of select="title" /></xsl:text>
                          </span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span class="bg-danger text-danger">Untitled Event</span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </a>
									</td>
									<td class="text-center">
										<a>
											<xsl:attribute name="href">
												<xsl:choose>
													<xsl:when test="parentId &gt; 0">
														<xsl:value-of select="concat('javascript:deleteNotify(', $quote, parentId, $quote, ',', $quote, id, $quote, ')')" />
													</xsl:when>
													<xsl:otherwise>
															<xsl:value-of select="concat('javascript:deleteEvent(', $quote, id, $quote, ');submitForm();')" />
													</xsl:otherwise>
												</xsl:choose>
											</xsl:attribute>
                      <span class="fa fa-trash fa-lg" />
										</a>
									</td>
									<td class="text-center">
										<a href="{concat($detailBaseUrl, '?eventID=', id)}" target="_blank">
                      <span class="fa fa-search fa-lg" />
										</a>
									</td>
								</tr>
								<xsl:for-each select="/data/calendar/event[parentId=$id]">
									<tr class="event-row collapsed-{parentId} bg-info" data-toggle="collapse" style="display:none;">
										<th>&#160;</th>
										<td class="text-center">
											<xsl:variable name="startDate">
												<xsl:variable name="year" select="substring(startDate, 1, 4)" />
												<xsl:variable name="month" select="substring(startDate, 6, 2)" />
												<xsl:variable name="day" select="substring(startDate, 9, 2)" />
												<xsl:value-of select="concat($month, '/', $day, '/', $year)" />
											</xsl:variable>
											<xsl:value-of select="$startDate" />
										</td>
										<!--
										<td class="text-center">
											<xsl:variable name="endDate">
												<xsl:variable name="year" select="substring(endDate, 1, 4)" />
												<xsl:variable name="month" select="substring(endDate, 6, 2)" />
												<xsl:variable name="day" select="substring(endDate, 9, 2)" />
												<xsl:value-of select="concat($month, '/', $day, '/', $year)" />
											</xsl:variable>
											<xsl:value-of select="$endDate" />
										</td>
									-->
										<td class="text-center">
											<span>
												<xsl:attribute name="class">
													<xsl:choose>
														<xsl:when test="published = 'true'">fa fa-check</xsl:when>
														<xsl:otherwise>fa fa-close</xsl:otherwise>
													</xsl:choose>
												</xsl:attribute>
											</span>
										</td>
										<td>
											<a href="javascript:editEvent('{id}');submitForm();">
												<xsl:attribute name="href">
													<xsl:choose>
														<xsl:when test="parentId &gt; 0">
															<xsl:value-of select="concat('javascript:editNotify(', $quote, parentId, $quote, ',', $quote, id, $quote, ')')" />
														</xsl:when>
														<xsl:otherwise>
																<xsl:value-of select="concat('javascript:editEvent(', $quote, id, $quote, ');submitForm();')" />
														</xsl:otherwise>
													</xsl:choose>
												</xsl:attribute>
												<xsl:choose>
													<xsl:when test="string-length(title) &gt; 0">
														<span>
															<xsl:text><xsl:value-of select="title" /></xsl:text>
														</span>
													</xsl:when>
													<xsl:otherwise>
														<span class="bg-danger text-danger">Untitled Event</span>
													</xsl:otherwise>
												</xsl:choose>
											</a>
										</td>
										<td class="text-center">
											<a>
												<xsl:attribute name="href">
													<xsl:choose>
														<xsl:when test="parentId &gt; 0">
															<xsl:value-of select="concat('javascript:deleteNotify(', $quote, parentId, $quote, ',', $quote, id, $quote, ')')" />
														</xsl:when>
														<xsl:otherwise>
																<xsl:value-of select="concat('javascript:deleteEvent(', $quote, id, $quote, ');submitForm();')" />
														</xsl:otherwise>
													</xsl:choose>
												</xsl:attribute>
												<span class="fa fa-trash fa-lg" />
											</a>
										</td>
										<td>&#160;</td>
									</tr>
								</xsl:for-each>
							</xsl:for-each>
						</tbody>
					</table>
					<div class="sr-only" id="delete-dialog" title="Delete event(s)">
						<p>Which would you like to delete?</p>
						<div class="form-row">
							<a class="label label-info" onclick="originalEventDelete()">Original Event</a>
							<span class="help-block">Delete this event if you wish for the action to be applied to all recurring events.</span>
						</div>
						<div class="form-row">
							<a class="label label-info" onclick="thisEventDelete();">This Event</a>
							<span class="help-block">Delete this event if you wish to remove only this event.</span>
						</div>
						<script>
							function deleteNotify(parentId, id)
							{
								$(function() {
									$("#delete-dialog").dialog().data('parentId', parentId).data('thisId', id);
								});
							}
							function originalEventDelete()
							{
								var id = '' + $("#delete-dialog").data('parentId');
								deleteEvent(id);
								submitForm();
							}
							function thisEventDelete()
							{
								var id = '' + $("#delete-dialog").data('thisId');
								deleteEvent(id);
								submitForm();
							}
						</script>
					</div>
					<div class="sr-only" id="edit-dialog" title="Edit event(s)">
						<p>Which would you like to edit?</p>
						<div class="form-row">
							<a class="label label-info" onclick="originalEvent()">Original Event</a>
							<span class="help-block">Modify this one if you wish for the change(s) to be applied to all recurring events.</span>
						</div>
						<div class="form-row">
							<a class="label label-info" onclick="thisEvent();">This Event</a>
							<span class="help-block">Modify this one if you wish to make a change to only this event.</span>
						</div>
						<script>
							function editNotify(parentId, id)
							{
								$(function() {
									$("#edit-dialog").dialog().data('parentId', parentId).data('thisId', id);
								});
							}
							function originalEvent()
							{
								var id = '' + $("#edit-dialog").data('parentId');
								editEvent(id);
								submitForm();
							}
							function thisEvent()
							{
								var id = '' + $("#edit-dialog").data('thisId');
								editEvent(id);
								submitForm();
							}
						</script>
					</div>
					<div class="btn-toolbar btn-actions">
						<a class="btn btn-default disabled" href="javascript:submitForm();">Save</a>
						<a class="btn btn-default" href="javascript:calendars();submitForm();">Back to Calendars</a>
						<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Calendar</a>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>
