<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="isSelfAssessment">
		<xsl:choose>
			<xsl:when test="/data/environment/componentId = 2">true</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="webformBaseUrl">
		<xsl:choose>
			<xsl:when test="$isSelfAssessment = 'true'">
				<xsl:value-of select="concat(/data/environment/serverName, '/webform/self-assessment/')" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat(/data/environment/serverName, '/webform/public/')" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="webformById" select="concat($webformBaseUrl, /data/form/id)" />
	<xsl:variable name="webformPrettyUrl" select="concat($webformBaseUrl, /data/form/prettyUrl)" />
	<xsl:variable name="webformUrlToUse">
		<xsl:value-of select="$webformBaseUrl" />
		<xsl:choose>
			<xsl:when test="string-length(/data/form/prettyUrl) &gt; 0"><xsl:value-of select="/data/form/prettyUrl" /></xsl:when>
			<xsl:otherwise><xsl:value-of select="/data/form/id" /></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:import href="form_nav.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="EDIT_MESSAGE" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<input type="hidden" name="MESSAGE_NAME" value="{/data/environment/screenName}" />
			<!-- survey content -->
			<xsl:variable name="webformBaseUrl" select="concat(/data/environment/serverName, 'webforms/self-assessment/')" />
			<xsl:variable name="webformUrl" select="concat($webformBaseUrl, /data/form/prettyUrl)" />
			<div class="row">
				<div class="col-lg-12">
					<nav>
						<xsl:variable name="QUESTION_ACTION">
								<xsl:choose>
									<xsl:when test="/data/environment/componentId = 1">QUESTION_LIST</xsl:when>
									<xsl:otherwise>QUESTIONS_AND_ANSWERS</xsl:otherwise>
								</xsl:choose>
						</xsl:variable>
						<xsl:call-template name="message_nav" />
					</nav>
					<h2>Self-Assessment Scores</h2>
					<xsl:if test="count(/data/message) &gt; 0">
						<xsl:for-each select="/data/message">
							<xsl:variable name="type">
								<xsl:choose>
									<xsl:when test="type='error'">danger</xsl:when>
									<xsl:when test="type='success'">success</xsl:when>
								</xsl:choose>
							</xsl:variable>
							<div class="alert alert-{$type}"><xsl:value-of select="label" /></div>
						</xsl:for-each>
					</xsl:if>
					<div class="form-row">
						<div class="row">
							<xsl:choose>
								<xsl:when test="/data/environment/screenName = 'MESSAGE_PUBLIC'">
									<div class="col-md-12">
										<label for="MESSAGE_INTRO">Intro</label>
										<input id="MESSAGE_INTRO" type="hidden" name="MESSAGE_INTRO" value="{/data/form/messagePublicFormIntro}"/>
										<trix-editor input="MESSAGE_INTRO"></trix-editor>
									</div>
									<div class="col-md-12">
										<label for="MESSAGE_CLOSING">Closing</label>
										<input id="MESSAGE_CLOSING" type="hidden" name="MESSAGE_CLOSING" value="{/data/form/messagePublicFormClosing}"/>
										<trix-editor input="MESSAGE_CLOSING"></trix-editor>
									</div>
								</xsl:when>
								<xsl:otherwise>
									<div class="col-md-12">
										<label for="MESSAGE_BODY">Body</label>
										<input id="MESSAGE_BODY" type="hidden" name="MESSAGE_BODY">
											<xsl:attribute name="value">
												<xsl:choose>
													<xsl:when test="/data/environment/screenName = 'MESSAGE_NOT_STARTED'">
														<xsl:value-of select="/data/form/messageNotStarted" />
													</xsl:when>
													<xsl:when test="/data/environment/screenName = 'MESSAGE_ENDED'">
														<xsl:value-of select="/data/form/messageEnded" />
													</xsl:when>
													<xsl:when test="/data/environment/screenName = 'MESSAGE_MAX_SUBMISSIONS'">
														<xsl:value-of select="/data/form/messageMaxSubmitted" />
													</xsl:when>
													<xsl:when test="/data/environment/screenName = 'MESSAGE_ONE_PER_USER'">
														<xsl:value-of select="/data/form/messageOneSubmission" />
													</xsl:when>
													<xsl:when test="/data/environment/screenName = 'MESSAGE_THANK_YOU'">
														<xsl:value-of select="/data/form/messageThankYou" />
													</xsl:when>
												</xsl:choose>
											</xsl:attribute>
										</input>
										<trix-editor input="MESSAGE_BODY"></trix-editor>
									</div>
								</xsl:otherwise>
							</xsl:choose>
						</div>
					</div>
					<hr />
					<div class="btn-toolbar">
						<a class="btn btn-default" href="javascript:saveMessage();">Save</a>
						<a class="btn btn-default" href="javascript:formMessages();">Back to Messages</a>
						<a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="numeric_select">
		<xsl:param name="startIndex" />
		<xsl:param name="currentIndex" />
		<xsl:param name="selectedIndex" />
		<xsl:param name="endIndex" />

		<xsl:if test="$currentIndex &lt;= $endIndex">
			<option value="{$currentIndex}">
				<xsl:if test="$currentIndex = $selectedIndex">
					<xsl:attribute name="selected">selected</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="$currentIndex" />
			</option>
			<xsl:call-template name="numeric_select">
				<xsl:with-param name="startIndex" select="$startIndex" />
				<xsl:with-param name="currentIndex" select="$currentIndex + 1" />
				<xsl:with-param name="selectedIndex" select="$selectedIndex" />
				<xsl:with-param name="endIndex" select="$endIndex" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
