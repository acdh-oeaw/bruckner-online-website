<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:client="https://solidjs.com/client" version="3.0"
    exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes"
        omit-xml-declaration="yes"/>

    <xsl:import href="partials/tei-ref.xsl"/>
		<xsl:variable name="languages" as="map(*)">
            <xsl:map>
                <xsl:map-entry key="'de'" select="'de'"/>
                <xsl:map-entry key="'en'" select="'eng'"/>
            </xsl:map>
        </xsl:variable>
			<xsl:variable name="id" as="xs:string" select="//tei:idno[@type='Bruckner_Kopisten']"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type = 'main'][1]/text()"/>
        </xsl:variable>
        <xsl:apply-templates select="//tei:list[not(parent::tei:p[@decls])]"/>
    </xsl:template>

    <xsl:template match="tei:list">
			<section>
				<xsl:apply-templates select="tei:head"/>
				<div>
					<xsl:apply-templates select="tei:item"/>
				</div>
			</section>
		</xsl:template>

		<xsl:template match="tei:head">
		<xsl:variable name="xmlLang" select="@xml:lang"/>
			<h2 class="mt-1 {if ($xmlLang != 'de') then 'hidden' else ()}" lang="{for $k in map:keys($languages) return if ($languages($k) = @xml:lang) then $k else ()}"><xsl:apply-templates/></h2>
		</xsl:template>
		<xsl:template match="tei:item">
			<figure>
				<xsl:apply-templates select="tei:title"/>
				<div class="inline-flex items-start gap-x-2">
					<xsl:apply-templates select="tei:figure/tei:graphic"/>
				</div>
			</figure>
		</xsl:template>
		<xsl:template match="tei:title">
			<xsl:variable name="xmlLang" select="@xml:lang"/>
			<figcaption class="{if ($xmlLang != 'de') then 'hidden' else ()}" lang="{for $k in map:keys($languages) return if ($languages($k) = @xml:lang) then $k else ()}"><xsl:value-of select="."/></figcaption>
		</xsl:template>
		<xsl:template match="tei:ref">
			<a href="{'https://bk-img.acdh-dev.oeaw.ac.at/'||@target}"><xsl:apply-templates/></a>
		</xsl:template>
		<xsl:template match="tei:graphic">
			<xsl:variable name="source" select="data(tokenize(@url, '/'))"/>
			<img class="w-[100px] h-[100px]">
					<xsl:attribute name="src">
							<xsl:value-of select="
											concat(
											'https://bk-img.acdh-dev.oeaw.ac.at/',
											$source[last()])"/>
					</xsl:attribute>
			</img>
		</xsl:template>
		<xsl:template match="text()">
			<xsl:value-of select="."/>
		</xsl:template>
</xsl:stylesheet>
