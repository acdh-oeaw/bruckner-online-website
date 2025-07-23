<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map" version="3.0"
    exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes"
        omit-xml-declaration="yes"/>
    <xsl:import href="variables.xsl"/>
    <xsl:import href="partials/tei-ref.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type = 'sub'][1]/text()"/>
        </xsl:variable>
        <xsl:apply-templates select="//tei:body"/>
    </xsl:template>
    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:div[not(descendant::tei:div[@xml:lang])] | tei:body[not(descendant::tei:div[@xml:lang])]">
        <xsl:variable name="xmlLang" select="@xml:lang"/>
				<div class="{if (@xml:lang and preceding::tei:div[@xml:lang]) then 'hidden' else ()}">
				<xsl:if test="@xml:lang">
                <xsl:attribute name="lang" select="map:keys($languages)[$languages(.) = $xmlLang]"/>
            </xsl:if>
					<div class="grid gap-y-4 px-8 pb-12 pt-6 text-neutral-500">
            <h1 class="font-heading text-3xl font-bold leading-tight">
                <xsl:value-of select="tei:head"/>
            </h1>
						<div>
            	<xsl:apply-templates/>
						</div>
        </div>
				<xsl:if test="//tei:note[@type='footnote']">
							<section class="bg-neutral-100 px-8 pt-6 pb-12">
								<h2 class="sr-only">Fußnoten</h2>
								<ol class="grid gap-y-1 text-sm mb-0">
									<xsl:for-each select="tei:note[@type='footnote']">
										<xsl:apply-templates select="current()" mode="footnote"/>
									</xsl:for-each>
								</ol>
							</section>
						</xsl:if>
				</div>
    </xsl:template>
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    <xsl:template match="tei:head"> </xsl:template>
    <xsl:template match="tei:hi">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>
		<xsl:template match="tei:note"/>
		<xsl:template match="tei:note" mode="footnote">
			<li id="{@xml:id}"><xsl:apply-templates/></li>
		</xsl:template>
</xsl:stylesheet>
