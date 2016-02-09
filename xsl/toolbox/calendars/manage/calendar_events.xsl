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
    				<a class="btn btn-default" href="javascript:createEvent();"><span class="fa fa-calendar"><span class="hide">Add Event</span></span> Add Event</a>
    			</div>
					<table class="table table-condensed">
						<thead>
							<tr>
								<th class="col-lg-11">Title</th>
								<th class="col-lg-1 text-center">Delete</th>
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="/data/calendar/event">
								<tr class="event-row">
									<td>
										<a href="javascript:editEvent('{id}');">
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
										<xsl:choose>
											<xsl:when test="number(/data/form/submissionCount) &gt; 0">
												<span class="fa fa-plus-circle fa-lg fa-disabled" />
											</xsl:when>
											<xsl:otherwise>
												<a href="javascript:deleteQuestion('{id}');"><span class="fa fa-trash fa-lg" /></a>
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
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
