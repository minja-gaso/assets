<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template match="/">
					<xsl:for-each select="/data/form">
						<xsl:variable name="tableBorder" select="'1px solid #1690BB'" />
						<xsl:variable name="cellMargin" select="'4pt'" />
						<xsl:variable name="fontSize" select="'8pt'" />
						<xsl:variable name="primaryColor" select="'#1690BB'" />
						<xsl:variable name="primaryTextColor" select="'#FFFFFF'" />
						<xsl:variable name="secondaryColor" select="'#FFFFFF'" />
						<xsl:variable name="secondaryTextColor" select="'#383838'" />
						<xsl:for-each select="question">
							<xsl:variable name="questionId" select="id" />
								<xsl:choose>
									<xsl:when test="type='text' or type='textarea'">
										<xsl:variable name="totalCount" select="count(/data/submission/answer[questionId = $questionId])" />
										<xsl:variable name="answeredCountStr">
											<xsl:for-each select="/data/submission/answer[questionId = $questionId]">
												<xsl:if test="string-length(answerValue) &gt; 0">
													<xsl:value-of select="'1'" />
												</xsl:if>
											</xsl:for-each>
										</xsl:variable>
										<xsl:variable name="answeredCount" select="string-length($answeredCountStr)" />
										<table class="table table-condensed">
											<thead>
												<tr>
													<th class="col-lg-11"><xsl:value-of select="number" />. <xsl:value-of select="concat(label, ' ', $questionId)" /></th>
													<th class="col-lg-1">Submissions</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<th>Answered</th>
													<td class="text-center"><xsl:value-of select="$answeredCount" /></td>
												</tr>
												<tr>
													<th>Unanswered</th>
													<td class="text-center"><xsl:value-of select="$totalCount - $answeredCount" /></td>
												</tr>
												<xsl:if test="count(/data/submission/answer[questionId = $questionId]) &gt; 0">
													<tr>
														<th colspan="2">
															<ul>
																<xsl:for-each select="/data/submission/answer[questionId = $questionId]">
																	<xsl:if test="string-length(answerValue) &gt; 0">
																		<li><xsl:value-of select="answerValue" />...<xsl:value-of select="$questionId" /></li>																	
																	</xsl:if>
																</xsl:for-each>
															</ul>
														</th>
													</tr>
												</xsl:if>
											</tbody>
										</table>
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
										<table class="table table-condensed">
											<thead>
												<th class="col-lg-11"><xsl:value-of select="number" />. <xsl:value-of select="label" /></th>
												<th class="col-lg-1">Submissions</th>
											</thead>
											<tbody>
												<xsl:for-each select="possibleAnswer">
													<xsl:variable name="possibleAnswerId" select="id" />
													<tr>
														<th><xsl:value-of select="label" /></th>
														<td class="text-center"><xsl:value-of select="count(/data/submission/answer[answerValue = $possibleAnswerId])" /></td>
													</tr>
												</xsl:for-each>
												<xsl:if test="type = 'checkbox'">
													<tr>
														<th class="text-danger text-notice" colspan="2"><em>Note: Checkbox questions can have multiple answers per submission.</em></th>
													</tr>
												</xsl:if>
											</tbody>
										</table>
									</xsl:otherwise>
								</xsl:choose>
						</xsl:for-each>
					</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
