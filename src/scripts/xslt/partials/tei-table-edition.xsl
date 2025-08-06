<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:foo="foo.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:dc="http://purl.org/dc/terms/" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:sparql="http://www.w3.org/2005/sparql-results#" xmlns:my="http://test.org/" exclude-result-prefixes="#all" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"/>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Copy of tei-table needed for tables in editions.</h1>
            <p>Applied with apply-templates in html:body.</p>
            <p>The template "tei-table" can handle the tei/xml tag table and cell.</p>
            <p>The template is used to create a html table based on two different rule-sets.</p>
        </desc>
    </doc>

    <xsl:template match="tei:table" name="table">
        <xsl:param name="table-id"/>
        <div class="row justify-content-center bg-white">
            <div class="col-md-9">
                <div class="card">
                    <div class="bg-neutral-100">
                        <xsl:if test="./tei:head">
                            <h2 class="font-semibold p-4 mt-0">
                                <xsl:value-of select="./tei:head[1]"/>
                            </h2>
                            <!--<h4>
                                <xsl:value-of select="./tei:head[2]"/>
                            </h4>-->
                        </xsl:if>
                    </div>
                    <div class="card-body">
                        <xsl:choose>
                            <xsl:when test="./tei:row[@role='label' and @xml:lang='de']">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover" id="{$table-id}">
                                        <thead>
                                        <xsl:for-each select="./tei:row[@role='label' and @xml:lang='de']">
                                            <tr>
                                                <xsl:if test="not(
                                                    contains(parent::tei:table/tei:head[@xml:lang='de'],
                                                    'Tabelle'))">
                                                    <th>Nr.</th>
                                                </xsl:if>
                                                <xsl:apply-templates/>
                                                <!--<xsl:if test="ancestor::tei:div[@xml:id]">
                                                    <th>Kommentar</th>
                                                </xsl:if>-->
                                            </tr>
                                        </xsl:for-each>
                                        </thead>
                                        <tbody>
                                            <xsl:for-each select="./tei:row[@role='data']">
                                                <tr>
                                                    <xsl:if test="not(
                                                        contains(parent::tei:table/tei:head[@xml:lang='de'],
                                                        'Tabelle'))">
                                                        <td><xsl:value-of select="position()"/></td>
                                                    </xsl:if>
                                                    <xsl:apply-templates/>
                                                </tr>
                                            </xsl:for-each>
                                        </tbody>
                                    </table>
                                </div>
                            </xsl:when>
                            <!--<xsl:when test="./tei:row[@role='label' and @xml:lang='eng']">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover" id="{$table-id}" style="width:100%;">
                                        <thead>
                                            <xsl:for-each select="./tei:row[@role='label' and @xml:lang='eng']">
                                                <tr>
                                                    <xsl:if test="not(
                                                        contains(parent::tei:table/tei:head[@xml:lang='eng'],
                                                        'Table'))">
                                                        <th>No.</th>
                                                    </xsl:if>
                                                    <xsl:apply-templates/>
                                                    <!-\-<xsl:if test="ancestor::tei:div[@xml:id]">
                                                    <th>Kommentar</th>
                                                </xsl:if>-\->
                                                </tr>
                                            </xsl:for-each>
                                        </thead>
                                        <tbody>
                                            <xsl:for-each select="./tei:row[@role='data']">
                                                <tr>
                                                    <xsl:if test="not(
                                                        contains(parent::tei:table/tei:head[@xml:lang='eng'],
                                                        'Table'))">
                                                        <td><xsl:value-of select="position()"/></td>
                                                    </xsl:if>
                                                    <xsl:apply-templates/>
                                                </tr>
                                            </xsl:for-each>
                                        </tbody>
                                    </table>
                                </div>
                            </xsl:when>-->
                            <xsl:otherwise>
                                <div class="table-responsive">
                                    <xsl:if test="./tei:head">
                                        <h3><xsl:value-of select="./tei:head"/></h3>
                                    </xsl:if>
                                    <table class="table table-striped table-hover display" id="{$table-id}" style="width:auto;">
                                        <tbody>
                                            <xsl:for-each select="./tei:row">
                                                <tr>
                                                    <xsl:apply-templates/>
                                                </tr>
                                            </xsl:for-each>
                                        </tbody>
                                    </table>
                                </div>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="tei:cell">
        <xsl:choose>
            <xsl:when test="@role='label'">
                <th><xsl:apply-templates/></th>
            </xsl:when>
            <xsl:when test="@role='data'">
                <td><xsl:apply-templates/></td>
            </xsl:when>
            <xsl:when test="parent::tei:row[@role='label' and @xml:lang='de']">
                <xsl:choose>
                    <xsl:when test="contains(., 'Datierung des Werkes')">
                        <!--  ignore this cell -->
                    </xsl:when>
                    <xsl:when test="contains(., 'erschlossene Datierung der Kopie')">
                        <!--  ignore this cell -->
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test=". = 'Zeitraum'">
                                <th>
                                    <xsl:apply-templates/>
                                </th>
                                <th>von</th>
                                <th>bis</th>
                            </xsl:when>
                            <xsl:otherwise>
                                <th>
                                    <xsl:apply-templates/>
                                </th>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <!--<xsl:when test="parent::tei:row[@role='label' and @xml:lang='eng']">
                <xsl:choose>
                    <xsl:when test="contains(., 'Date of Composition')">
                        <!-\-  ignore this cell -\->
                    </xsl:when>
                    <xsl:when test="contains(., 'date conjectural')">
                        <!-\-  ignore this cell -\->
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test=". = 'Period'">
                                <th>
                                    <xsl:apply-templates/>
                                </th>
                                <th>from</th>
                                <th>to</th>
                            </xsl:when>
                            <xsl:otherwise>
                                <th>
                                    <xsl:apply-templates/>
                                </th>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>-->
            <!--<xsl:when test="parent::tei:row[@role='label' and @xml:lang='eng']">
                <th>
                    <xsl:apply-templates/>
                </th>
            </xsl:when>-->
            <xsl:when test="parent::tei:row[@role='data']">
                <xsl:choose>
                    <xsl:when test="@role='Kommentar_intern'">
                        <!-- ignore this cell -->
                    </xsl:when>
                    <xsl:when test="@role='Datierung'">
                        <!-- ignore this cell created numbered column -->
                    </xsl:when>
                    <xsl:when test="@role='erschlossene_Datierung_der_Kopie'">
                        <!-- ignore this cell created numbered column -->
                    </xsl:when>
                    <!--<xsl:when test="@role='WAB-Nummer'">
                        <td class="{@role}">
                            <xsl:apply-templates/>
                        </td>
                    </xsl:when>-->
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="@xml:lang='de'">
                                <td class="{@role}"><xsl:apply-templates/></td>
                                <xsl:if test="child::tei:date/@from and not(ancestor::tei:div[@xml:id])">
                                    <td>
                                        <xsl:value-of select="./tei:date/@from"/>
                                    </td>
                                    <td>
                                        <xsl:value-of select="./tei:date/@to"/>
                                    </td>
                                </xsl:if>
                            </xsl:when>
                            <xsl:when test="not(@xml:lang)">
                                <td class="{@role}">
																<xsl:if test="@role='Ort'">
																<xsl:attribute name="data-contenttype" select="'place'"/>
																	<xsl:variable name="placeref" select="substring(tei:rs/@ref,2)" />
																	<xsl:variable name="place" select="root(.)//tei:place[@xml:id=$placeref]"/>
																	<xsl:variable name="location" select="tokenize($place/tei:location/tei:geo/text())"/>
																 <xsl:attribute name="data-lat">
                                    <xsl:value-of select="$location[1]"/>
                                  </xsl:attribute>
                                  <xsl:attribute name="data-lng">
                                        <xsl:value-of select="$location[2]"/>
                                  </xsl:attribute>
																</xsl:if>
																	<xsl:apply-templates/>
																</td>
                                <xsl:if test="child::tei:date/@from and not(ancestor::tei:div[@xml:id])">
                                    <td>
                                        <xsl:value-of select="./tei:date/@from"/>
                                    </td>
                                    <td>
                                        <xsl:value-of select="./tei:date/@to"/>
                                    </td>
                                </xsl:if>
                            </xsl:when>
                            <xsl:otherwise>

                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <td><xsl:apply-templates/></td>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
