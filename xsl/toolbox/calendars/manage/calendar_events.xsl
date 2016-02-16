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
				<div class="col-lg-12">
					<nav>
						<xsl:call-template name="primary_content_navigation">
							<xsl:with-param name="SCREEN" select="'EVENTS'" />
						</xsl:call-template>
					</nav>
					<h2>Events for <em><xsl:value-of select="/data/calendar/title" /></em></h2>
					<xsl:call-template name="messages" />
    			<div class="btn-group pull-right">
    				<a class="btn btn-default" href="javascript:createEvent();submitForm();"><span class="fa fa-calendar"><span class="hide">Add Event</span></span> Add Event</a>
    			</div>
					<table class="table table-condensed">
						<thead>
							<tr>
								<th class="col-lg-2 col-md-1 col-sm-2 text-center">Start Date</th>
								<th class="col-lg-2 col-md-1 col-sm-2 text-center">End Date</th>
								<th class="col-lg-1 col-md-1 col-sm-2 text-center">Published</th>
								<th class="col-lg-7 col-md-9 col-sm-6">Title</th>
								<th class="col-lg-1 col-md-1 col-sm-2 text-center">Delete</th>
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="/data/calendar/event">
								<tr class="event-row">
									<xsl:if test="parentId &gt; 0">
										<xsl:attribute name="class">
											<xsl:text>event-row bg-info</xsl:text>
										</xsl:attribute>
									</xsl:if>
									<td class="text-center">
										<xsl:variable name="startDate">
											<xsl:variable name="year" select="substring(startDate, 1, 4)" />
											<xsl:variable name="month" select="substring(startDate, 6, 2)" />
											<xsl:variable name="day" select="substring(startDate, 9, 2)" />
											<xsl:value-of select="concat($month, '/', $day, '/', $year)" />
										</xsl:variable>
										<xsl:value-of select="$startDate" />
									</td>
									<td class="text-center">
										<xsl:variable name="endDate">
											<xsl:variable name="year" select="substring(endDate, 1, 4)" />
											<xsl:variable name="month" select="substring(endDate, 6, 2)" />
											<xsl:variable name="day" select="substring(endDate, 9, 2)" />
											<xsl:value-of select="concat($month, '/', $day, '/', $year)" />
										</xsl:variable>
										<xsl:value-of select="$endDate" />
									</td>
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
								</tr>
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
					<div class="form-row">
						<div class="btn-toolbar">
							<a class="btn btn-default" href="javascript:saveQuestions();">Save</a>
							<a class="btn btn-default" href="javascript:formListScreen();">Back to Forms</a>
							<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Form</a>
						</div>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>
