<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template match="/">
		<fo:root>
			<fo:layout-master-set>
				<fo:simple-page-master master-name="my-page">
					<fo:region-body margin="1in" />
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:declarations>
			  <x:xmpmeta xmlns:x="adobe:ns:meta/">
			    <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
			      <rdf:Description rdf:about=""
			          xmlns:dc="http://purl.org/dc/elements/1.1/">
			        <!-- Dublin Core properties go here -->
			        <dc:title><xsl:value-of select="/data/form/title" /></dc:title>
			        <dc:creator>Minja Gaso, mgaso@sw.org</dc:creator>
			        <dc:description>Summary report of submitted results.</dc:description>
			      </rdf:Description>
			      <rdf:Description rdf:about=""
			          xmlns:xmp="http://ns.adobe.com/xap/1.0/">
			        <!-- XMP properties go here -->
			        <xmp:CreatorTool>Tool used to make the PDF</xmp:CreatorTool>
			      </rdf:Description>
			    </rdf:RDF>
			  </x:xmpmeta>
			</fo:declarations>
			<fo:page-sequence master-reference="my-page">
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
	        	<fo:external-graphic src="url(http://www.sw.org/resources/images/site/bswh-central.png)" content-width="4.00in"></fo:external-graphic>
			    </fo:block>
					<xsl:for-each select="/data/form">
						<fo:block margin-top="12pt" margin-bottom="12pt">
							<xsl:value-of select="title" />
							<xsl:if test="/data/analytics">
								<fo:inline color="#808080" font-size="10pt" padding-left="12pt" margin-top="10pt" margin-bottom="12pt">
									<xsl:value-of select="/data/analytics/startDateStr" /> to <xsl:value-of select="/data/analytics/endDateStr" />
								</fo:inline>
							</xsl:if>
						</fo:block>
						<xsl:variable name="tableBorder" select="'1px solid #1690BB'" />
						<xsl:variable name="cellMargin" select="'4pt'" />
						<xsl:variable name="fontSize" select="'8pt'" />
						<xsl:variable name="primaryColor" select="'#1690BB'" />
						<xsl:variable name="primaryTextColor" select="'#FFFFFF'" />
						<xsl:variable name="secondaryColor" select="'#FFFFFF'" />
						<xsl:variable name="secondaryTextColor" select="'#383838'" />
						<xsl:for-each select="question">
							<xsl:variable name="questionId" select="id" />
							<fo:block page-break-inside="avoid">
								<xsl:choose>
									<xsl:when test="type='text' or type='textarea'">
										<xsl:variable name="totalCount" select="count(/data/submission)" />
										<xsl:variable name="answeredCountStr">
											<xsl:for-each select="/data/submission/answer[questionId = $questionId]">
												<xsl:if test="string-length(answerValue) &gt; 0">
													<xsl:value-of select="'1'" />
												</xsl:if>
											</xsl:for-each>
										</xsl:variable>
										<xsl:variable name="answeredCount" select="string-length($answeredCountStr)" />
										<fo:table border="{$tableBorder}" margin-bottom="8pt">
											<fo:table-column column-width="80%"/>
											<fo:table-column column-width="20%"/>
											<fo:table-body>
												<!-- header row containing question number and label -->
												<fo:table-row>
													<fo:table-cell background-color="{$primaryColor}" color="{$primaryTextColor}" font-size="{$fontSize}" font-weight="bold">
														<fo:block margin="{$cellMargin}">
															<xsl:value-of select="number" />. <xsl:value-of select="label" />
														</fo:block>
													</fo:table-cell>
													<fo:table-cell background-color="{$primaryColor}" color="{$primaryTextColor}" font-size="{$fontSize}" font-weight="bold" text-align="center">
														<fo:block margin="{$cellMargin}">
															Submissions
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
												<!-- answered -->
												<fo:table-row>
													<fo:table-cell border-bottom="1px solid {$primaryColor}" background-color="{$secondaryColor}" font-size="{$fontSize}" font-weight="bold" text-align="right">
														<fo:block margin="{$cellMargin}">
															Answered
														</fo:block>
													</fo:table-cell>
													<fo:table-cell border-bottom="1px solid {$primaryColor}" border-left="1px solid {$primaryColor}" font-size="{$fontSize}" text-align="center">
														<fo:block margin="{$cellMargin}">
															<xsl:value-of select="$answeredCount" />
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
												<!-- unanswered -->
												<fo:table-row>
													<fo:table-cell background-color="{$secondaryColor}" font-size="{$fontSize}" font-weight="bold" text-align="right">
														<fo:block margin="{$cellMargin}">
															Unanswered
														</fo:block>
													</fo:table-cell>
													<fo:table-cell border-bottom="1px solid {$primaryColor}" border-left="1px solid {$primaryColor}" font-size="{$fontSize}" text-align="center">
														<fo:block margin="{$cellMargin}">
															<xsl:value-of select="$totalCount - $answeredCount" />
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
											</fo:table-body>
										</fo:table>
									</xsl:when>
									<xsl:otherwise>

										<xsl:variable name="totalCount" select="count(/data/submission/answer[questionId = $questionId])" />
										<xsl:variable name="answeredCountStr">
											<xsl:for-each select="/data/submission/answer[questionId = $questionId]">
												<xsl:if test="string-length(answerValue) &gt; 0">
													<xsl:value-of select="'1'" />
												</xsl:if>
											</xsl:for-each>
										</xsl:variable>
										<xsl:variable name="answeredCount" select="string-length($answeredCountStr)" />

										<fo:table border="{$tableBorder}" margin-bottom="8pt">
											<fo:table-column column-width="80%"/>
											<fo:table-column column-width="20%"/>
											<fo:table-body>
												<!-- header row containing question number and label -->
												<fo:table-row>
													<fo:table-cell background-color="{$primaryColor}" color="{$primaryTextColor}" font-size="{$fontSize}" font-weight="bold">
														<fo:block margin="{$cellMargin}">
															<xsl:value-of select="number" />. <xsl:value-of select="label" />
														</fo:block>
													</fo:table-cell>
													<fo:table-cell background-color="{$primaryColor}" color="{$primaryTextColor}" font-size="{$fontSize}" font-weight="bold" text-align="center">
														<fo:block margin="{$cellMargin}">
															Submissions
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
												<!-- possible answers -->
												<xsl:for-each select="possibleAnswer">
													<xsl:variable name="possibleAnswerId" select="id" />
													<fo:table-row>
														<fo:table-cell border-bottom="1px solid {$primaryColor}" background-color="{$secondaryColor}" font-size="{$fontSize}" font-weight="bold" text-align="right">
															<fo:block margin="{$cellMargin}">
																<xsl:value-of select="label" />
															</fo:block>
														</fo:table-cell>
														<fo:table-cell border-bottom="1px solid {$primaryColor}" border-left="1px solid {$primaryColor}" font-size="{$fontSize}" text-align="center">
															<fo:block margin="{$cellMargin}">
																<xsl:value-of select="count(/data/submission/answer[answerValue = $possibleAnswerId])" />
															</fo:block>
														</fo:table-cell>
													</fo:table-row>
												</xsl:for-each>
												<!-- notice -->
												<xsl:if test="type='checkbox'">
													<fo:table-row>
														<fo:table-cell background-color="#F7F7F7" color="#808080" font-size="6pt" font-style="italic" font-weight="normal" text-align="left" number-columns-spanned="2">
															<fo:block margin="{$cellMargin}">
																Note: Checkbox questions can have multiple answers per submission.
															</fo:block>
														</fo:table-cell>
													</fo:table-row>
												</xsl:if>
											</fo:table-body>
										</fo:table>



									</xsl:otherwise>
								</xsl:choose>
							</fo:block>
						</xsl:for-each>
					</xsl:for-each>
					<!--
					<fo:table-and-caption>
						<fo:table>
							<fo:table-column column-width="25mm" />
							<fo:table-column column-width="25mm" />
							<fo:table-header>
								<fo:table-row>
									<fo:table-cell>
										<fo:block font-weight="bold">Dept</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">Title</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-header>
							<xsl:for-each select="/data/blog">
								<fo:table-body>
									<fo:table-row>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="title" />
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="'a'" />
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</xsl:for-each>
						</fo:table>
					</fo:table-and-caption> -->
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>
