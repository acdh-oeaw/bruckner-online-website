<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0" exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes"
        omit-xml-declaration="yes"/>

    <!--<xsl:import href="partials/osd-container.xsl"/>-->
    <!--<xsl:import href="partials/tei-facsimile.xsl"/>-->
    <xsl:import href="partials/tei-ref.xsl"/>
    <xsl:import href="partials/tei-table.xsl"/>
    <xsl:import href="partials/dataTable-base.xsl"/>
    <xsl:import href="partials/leaflet-base.xsl"/>

    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type = 'main'][1]/text()"/>
        </xsl:variable>
        <!--<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <xsl:for-each select="//tei:cell[@role='Signatur']">
                    <meta name="Signatur" class="staticSearch_desc">
                        <xsl:attribute name="content">
                            <xsl:value-of select="normalize-space(.)"/>
                        </xsl:attribute>
                    </meta>
                </xsl:for-each>
                <xsl:for-each select="//tei:cell[@role='WAB-Nummer']">
                    <meta name="WAB-Nummer" class="staticSearch_desc">
                        <xsl:attribute name="content">
                            <xsl:value-of select="normalize-space(.)"/>
                        </xsl:attribute>
                    </meta>
                </xsl:for-each>
                <meta name="docTitle" class="staticSearch_docTitle">
                    <xsl:attribute name="content">
                        <xsl:value-of select="//tei:titleStmt/tei:title[@level='a']"/>
                    </xsl:attribute>
                </meta>
                <xsl:call-template name="datatable-base"/>
                <!-/-<xsl:call-template name="leaflet-base"/>-/->
                <style>
                    .container-fluid {
                        max-width: 100%;
                    }
                </style>
            </head>


            <body class="page">
                <div class="hfeed site" id="page">

                    <div class="container-fluid">-->

        <div>
            <xsl:apply-templates select=".//tei:body"/>
        </div>
        <!-- </div>
                <script type="text/javascript" src="js/dt.js"></script>
                <script type="text/javascript">
                    $(document).ready(function () {
                        createDataTable('editions-table');
                    });
                </script>
                <script type="text/javascript" src="js/citation-date.js"></script>
            </body>
        </html>-->
    </xsl:template>

    <xsl:template match="tei:div">
        <div class="kopisten-content" id="{@xml:id}">
            <xsl:apply-templates>
                <xsl:with-param name="table-id" select="'editions-table'"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>
    <xsl:template match="tei:listPerson">
        <xsl:for-each select="./tei:person">
            <xsl:variable name="cp-cleaning1" select="
                    replace(
                    replace(
                    replace(
                    replace(
                    replace(
                    replace(
                    translate(./tei:persName[@type = 'main'], ' ', '-')
                    , ',', '')
                    , 'ß', 'ss')
                    , '[éè]', 'e')
                    , 'ä', 'a')
                    , 'ö', 'o')
                    , 'ü', 'u')
                    "/>
            <xsl:variable name="cp-cleaning2" select="data(translate($cp-cleaning1, '.', ''))"/>
            <xsl:variable name="cp-clean"
                select="translate($cp-cleaning2, '&#xA0;', '-') => lower-case()"/>
            <div class="row justify-content-center">
                <div class="col-md-9">
                    <ul class="nav nav-tabs info-box-link justify-content-end" id="dropdown-lang">
                        <li class="nav-item">
                            <a title="Deutsch" href="#info-lang-de" data-toggle="tab"
                                class="nav-link btn btn-round active"> DE </a>
                        </li>
                        <li class="nav-item">
                            <a title="English" href="#info-lang-en" data-toggle="tab"
                                class="nav-link btn btn-round"> EN </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="tab-content">
                <div class="tab-pane active" id="info-lang-de">
                    <div class="grid gap-x-2">
                        <div class="card" style="margin-top:0;">
                            <div class="card-header">
                                <xsl:choose>
                                    <xsl:when test="./tei:persName[@subtype]">
                                        <div>
                                            <div>
                                                <h2 class="text-left">
                                                  <span class="text">
                                                  <xsl:value-of select="
                                                                concat(
                                                                ./tei:persName[@type = 'main'],
                                                                ' (', ./tei:persName[@type = 'main']/@subtype, ')')"
                                                  />
                                                  </span>
                                                </h2>
                                            </div>

                                        </div>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <div class="row">
                                            <div class="col-md-7">
                                                <h2 class="text-left">
                                                  <span class="text">
                                                  <xsl:value-of
                                                  select="./tei:persName[@type = 'main']"/>
                                                  </span>
                                                </h2>
                                            </div>
                                        </div>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </div>
                            <div class="card-body">
                                <dl class="grid gap-y-2">
                                    <xsl:if test="./tei:persName[@type = 'before']/text()">
                                        <div class="inline-flex items-center gap-x-2">
                                            <dt>Vorherige Namen</dt>
                                            <xsl:choose>
                                                <xsl:when
                                                  test="./tei:persName[@type = 'before']/text()">
                                                  <dd>
                                                  <xsl:value-of
                                                  select="./tei:persName[@type = 'before']"/>
                                                  </dd>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                  <dd>k. A.</dd>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                    </xsl:if>
                                    <div class="inline-flex items-center gap-x-2">
                                        <dt>Normdaten</dt>
                                        <xsl:choose>
                                            <xsl:when test="./tei:idno[@type = 'GND']/text()">
                                                <dd>
                                                  <a href="{concat('https://d-nb.info/gnd/',
																									./tei:idno[@type='GND'])}"
                                                  title="open GND database" target="_blank">
                                                  <xsl:value-of select="
                                                                concat('https://d-nb.info/gnd/',
                                                                ./tei:idno[@type = 'GND'])"
                                                  />
                                                  </a>
                                                </dd>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <dd>k. A.</dd>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                                    <div class="inline-flex items-center gap-x-2">
                                        <dt>ABLO / ÖML</dt>
                                        <xsl:choose>
                                            <xsl:when
                                                test="ancestor::tei:listPerson/following-sibling::tei:p[@decls = 'link']/tei:ref/@target">
                                                <dd>
                                                  <a
                                                  href="{ancestor::tei:listPerson/following-sibling::tei:p[@decls='link']/tei:ref/@target}"
                                                  title="read more" target="_blank">
                                                  <svg xmlns="http://www.w3.org/2000/svg" width="16"
                                                  height="16" fill="currentColor"
                                                  class="bi bi-box-arrow-up-right"
                                                  viewBox="0 0 16 16">
                                                  <path fill-rule="evenodd"
                                                  d="M8.636 3.5a.5.5 0 0 0-.5-.5H1.5A1.5 1.5 0 0 0 0 4.5v10A1.5 1.5 0 0 0 1.5 16h10a1.5 1.5 0 0 0 1.5-1.5V7.864a.5.5 0 0 0-1 0V14.5a.5.5 0 0 1-.5.5h-10a.5.5 0 0 1-.5-.5v-10a.5.5 0 0 1 .5-.5h6.636a.5.5 0 0 0 .5-.5z"/>
                                                  <path fill-rule="evenodd"
                                                  d="M16 .5a.5.5 0 0 0-.5-.5h-5a.5.5 0 0 0 0 1h3.793L6.146 9.146a.5.5 0 1 0 .708.708L15 1.707V5.5a.5.5 0 0 0 1 0v-5z"
                                                  />
                                                  </svg>
                                                  </a>
                                                </dd>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <dd>k. A.</dd>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                                    <div class="inline-flex items-center gap-x-2">
                                        <dt>Residenz</dt>
                                        <xsl:choose>
                                            <xsl:when test="./tei:residence/text()">
                                                <dd>
                                                  <xsl:value-of select="./tei:residence"/>
                                                </dd>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <dd>k. A.</dd>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                                    <div class="inline-flex items-center gap-x-2">
                                        <dt>Zeitraum der Kopiertätigkeit</dt>
                                        <xsl:choose>
                                            <xsl:when test="./tei:floruit[@xml:lang = 'de']/text()">
                                                <dd>
                                                  <xsl:value-of
                                                  select="./tei:floruit[@xml:lang = 'de']"/>
                                                </dd>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <dd>k. A.</dd>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                                    <div>
                                        <dt>TEI/XML Export</dt>
                                        <dd>
                                            <a
                                                href="https://acdh-oeaw.github.io/bruckner-kopisten-static/{$cp-clean}.xml?format=raw">
                                                <i class="fas fa-2x fa-file-download"/>
                                            </a>
                                        </dd>
                                    </div>
                                    <div>
                                        <xsl:variable name="citation-text-de"
                                            select="//tei:title[@level = 'a']"/>
                                        <xsl:variable name="citation-link-de" select="
                                                concat('https://bruckner-kopisten.acdh.oeaw.ac.at/',
                                                $cp-clean,
                                                '.html')"/>
                                        <dd>Zitierhinweis</dd>
                                        <dt>
                                            <xsl:value-of select="$citation-text-de"/>
                                            <xsl:text> [Kopistendatensatz], in: </xsl:text>
                                            <cite>Die Kopisten der Werke Anton Bruckners</cite>
                                            <xsl:text>, hrsg. von Paul Hawkshaw und Clemens Gubsch (</xsl:text>
                                            <a href="{lower-case($citation-link-de)}">
                                                <xsl:value-of select="lower-case($citation-link-de)"
                                                />
                                            </a>
                                            <xsl:text>), abgerufen am </xsl:text>
                                            <span class="citationDateDe">
                                                <xsl:value-of
                                                  select="format-date(current-date(), '[D].[M].[Y]')"
                                                />
                                            </span>
                                            <xsl:text>.</xsl:text>
                                        </dt>
                                    </div>
                                </dl>
                            </div>
                            <div class="card-footer">
                                <xsl:for-each select="./tei:index/tei:term[@xml:lang = 'de']">
                                    <span class="badge text-light text" style="margin-right:.2em;">
                                        <xsl:apply-templates/>
                                    </span>
                                </xsl:for-each>
                            </div>
                        </div>
                        <div class="col-span-3">
                            <xsl:if test="//tei:p[parent::tei:div][@xml:lang = 'de']/text()">
                                <div class="card" style="margin-top:0;">
                                    <div class="card-header">
                                        <h2>Beschreibung</h2>
                                    </div>
                                    <div class="card-body">
                                        <xsl:for-each
                                            select="//tei:p[@decls = 'desc'][parent::tei:div][@xml:lang = 'de']">
                                            <span class="text">
                                                <xsl:apply-templates/>
                                            </span>
                                        </xsl:for-each>
                                    </div>
                                    <div class="card-footer">
                                        <ul>
                                            <xsl:for-each
                                                select="//tei:note[parent::tei:p[@xml:lang = 'de']]">
                                                <li>
                                                  <a
                                                  href="#{replace(@xml:id, 'footnote', 'footnote-ref')}">
                                                  <span
                                                  style="margin-right:.2em;vertical-align:super;">
                                                  <small>
                                                  <xsl:value-of select="@n"/>
                                                  </small>
                                                  </span>
                                                  </a>
                                                  <span class="note" id="{@xml:id}">
                                                  <xsl:apply-templates/>
                                                  </span>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </div>
                                </div>

                            </xsl:if>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="info-lang-en">
                    <div class="row justify-content-center">
                        <div class="col-md-3">
                            <div class="card" style="margin-top:0;">
                                <div class="card-header">
                                    <xsl:choose>
                                        <xsl:when test="./tei:persName[@subtype]">
                                            <div class="row">
                                                <div class="col-md-7">
                                                  <h2 class="text-left">
                                                  <span class="text">
                                                  <xsl:value-of select="
                                                                    concat(
                                                                    ./tei:persName[@type = 'main'],
                                                                    ' (', ./tei:persName[@type = 'main']/@subtype, ')')"
                                                  />
                                                  </span>
                                                  </h2>
                                                </div>

                                            </div>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <div class="row">
                                                <div class="col-md-7">
                                                  <h2 class="text-left">
                                                  <span class="text">
                                                  <xsl:value-of
                                                  select="./tei:persName[@type = 'main']"/>
                                                  </span>
                                                  </h2>
                                                </div>
                                            </div>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </div>
                                <div class="card-body">
                                    <table class="table info-box">
                                        <tbody>
                                            <xsl:if test="./tei:persName[@type = 'before']/text()">
                                                <tr>
                                                  <th>Previous Names</th>
                                                  <xsl:choose>
                                                  <xsl:when
                                                  test="./tei:persName[@type = 'before']/text()">
                                                  <td>
                                                  <xsl:value-of
                                                  select="./tei:persName[@type = 'before']"/>
                                                  </td>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <td>k. A.</td>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </tr>
                                            </xsl:if>
                                            <tr>
                                                <th>Normdata</th>
                                                <xsl:choose>
                                                  <xsl:when test="./tei:idno[@type = 'GND']/text()">
                                                  <td>
                                                  <a href="{concat('https://d-nb.info/gnd/',
                                                                ./tei:idno[@type='GND'])}"
                                                  title="open GND database" target="_blank">
                                                  <xsl:value-of select="
                                                                        concat('https://d-nb.info/gnd/',
                                                                        ./tei:idno[@type = 'GND'])"
                                                  />
                                                  </a>
                                                  </td>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <td>k. A.</td>
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </tr>
                                            <tr>
                                                <th>ABLO / OEML</th>
                                                <xsl:choose>
                                                  <xsl:when
                                                  test="ancestor::tei:listPerson/following-sibling::tei:p[@decls = 'link']/tei:ref/@target">
                                                  <td>
                                                  <a
                                                  href="{ancestor::tei:listPerson/following-sibling::tei:p[@decls='link']/tei:ref/@target}"
                                                  title="read more" target="_blank">
                                                  <svg xmlns="http://www.w3.org/2000/svg" width="16"
                                                  height="16" fill="currentColor"
                                                  class="bi bi-box-arrow-up-right"
                                                  viewBox="0 0 16 16">
                                                  <path fill-rule="evenodd"
                                                  d="M8.636 3.5a.5.5 0 0 0-.5-.5H1.5A1.5 1.5 0 0 0 0 4.5v10A1.5 1.5 0 0 0 1.5 16h10a1.5 1.5 0 0 0 1.5-1.5V7.864a.5.5 0 0 0-1 0V14.5a.5.5 0 0 1-.5.5h-10a.5.5 0 0 1-.5-.5v-10a.5.5 0 0 1 .5-.5h6.636a.5.5 0 0 0 .5-.5z"/>
                                                  <path fill-rule="evenodd"
                                                  d="M16 .5a.5.5 0 0 0-.5-.5h-5a.5.5 0 0 0 0 1h3.793L6.146 9.146a.5.5 0 1 0 .708.708L15 1.707V5.5a.5.5 0 0 0 1 0v-5z"
                                                  />
                                                  </svg>
                                                  </a>
                                                  </td>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <td>k. A.</td>
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </tr>
                                            <tr>
                                                <th>Residence</th>
                                                <xsl:choose>
                                                  <xsl:when test="./tei:residence/text()">
                                                  <td>
                                                  <xsl:value-of select="./tei:residence"/>
                                                  </td>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <td>k. A.</td>
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </tr>
                                            <tr>
                                                <th>Period of copying activity</th>
                                                <xsl:choose>
                                                  <xsl:when
                                                  test="./tei:floruit[@xml:lang = 'eng']/text()">
                                                  <td>
                                                  <xsl:value-of
                                                  select="./tei:floruit[@xml:lang = 'eng']"/>
                                                  </td>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <td>k. A.</td>
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </tr>
                                            <tr>
                                                <th>TEI/XML Export</th>
                                                <td>
                                                  <a
                                                  href="https://acdh-oeaw.github.io/bruckner-kopisten-static/{$cp-clean}.xml?format=raw">
                                                  <i class="fas fa-2x fa-file-download"/>
                                                  </a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <xsl:variable name="citation-text-de"
                                                  select="//tei:title[@level = 'a']"/>
                                                <xsl:variable name="citation-link-en" select="
                                                        concat('https://bruckner-kopisten.acdh.oeaw.ac.at/',
                                                        $cp-clean,
                                                        '.html')"/>
                                                <th>Citation note</th>
                                                <td>
                                                  <xsl:value-of select="$citation-text-de"/>
                                                  <xsl:text> [copyist record], in: </xsl:text>
                                                  <cite>Die Kopisten der Werke Anton
                                                  Bruckners</cite>
                                                  <xsl:text>, ed. by Paul Hawkshaw and Clemens Gubsch (</xsl:text>
                                                  <a href="{lower-case($citation-link-en)}">
                                                  <xsl:value-of
                                                  select="lower-case($citation-link-en)"/>
                                                  </a>
                                                  <xsl:text>), accessed on </xsl:text>
                                                  <span class="citationDateEn">
                                                  <xsl:value-of
                                                  select="format-date(current-date(), '[D].[M].[Y]')"
                                                  />
                                                  </span>
                                                  <xsl:text>.</xsl:text>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="card-footer">
                                    <xsl:for-each select="./tei:index/tei:term[@xml:lang = 'eng']">
                                        <span class="badge text-light text"
                                            style="margin-right:.2em;">
                                            <xsl:apply-templates/>
                                        </span>
                                    </xsl:for-each>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <xsl:if test="//tei:p[parent::tei:div][@xml:lang = 'eng']/text()">
                                <div class="card" style="margin-top:0;">
                                    <div class="card-header">
                                        <h3>Description</h3>
                                    </div>
                                    <div class="card-body">
                                        <xsl:for-each
                                            select="//tei:p[parent::tei:div][@xml:lang = 'eng']">
                                            <span class="text">
                                                <xsl:apply-templates/>
                                            </span>
                                        </xsl:for-each>
                                    </div>
                                    <div class="card-footer">
                                        <ul>
                                            <xsl:for-each
                                                select="//tei:note[parent::tei:p[@xml:lang = 'eng']]">
                                                <li>
                                                  <a
                                                  href="#{replace(@xml:id, 'footnote', 'footnote-ref')}">
                                                  <span
                                                  style="margin-right:.2em;vertical-align:super;">
                                                  <small>
                                                  <xsl:value-of select="@n"/>
                                                  </small>
                                                  </span>
                                                  </a>
                                                  <span class="note" id="{@xml:id}">
                                                  <xsl:apply-templates/>
                                                  </span>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </div>
                                </div>
                            </xsl:if>
                        </div>
                    </div>
                </div>
            </div>
        </xsl:for-each>

    </xsl:template>
    <xsl:template match="tei:p"> </xsl:template>
    <xsl:template match="tei:note"> </xsl:template>
    <xsl:template match="tei:list">
        <xsl:choose>
            <xsl:when test="parent::tei:p">
                <ul style="margin-top:.5em;">
                    <xsl:apply-templates/>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <div class="row justify-content-center">
                    <div class="col-md-9">
                        <div class="card" style="margin-top:-.5em;border-top:none!important;">
                            <div class="card-header">
                                <h5>
                                    <xsl:for-each select="./tei:head[@xml:lang = 'de']">
                                        <xsl:apply-templates/>
                                    </xsl:for-each> | <xsl:for-each
                                        select="./tei:head[@xml:lang = 'eng']">
                                        <xsl:apply-templates/>
                                    </xsl:for-each>
                                </h5>
                            </div>
                            <div class="card-footer">
                                <ul>
                                    <xsl:apply-templates/>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:head"> </xsl:template>
    <xsl:template match="tei:hi">
        <xsl:choose>
            <xsl:when test="@rend = 'sup'">
                <span style="vertical-align:super;">
                    <small>
                        <xsl:apply-templates/>
                    </small>
                </span>
            </xsl:when>
            <xsl:when test="@rend = 'italic'">
                <span style="font-style:italic;">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span>
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:item">
        <xsl:choose>
            <xsl:when test="ancestor::tei:p">
                <li style="list-style: decimal;">
                    <xsl:apply-templates/>
                </li>
            </xsl:when>
            <xsl:otherwise>
                <li style="margin:2em;">
                    <h6>
                        <xsl:value-of select="
                                ./tei:title[@xml:lang = 'de']"/> |
                            <xsl:value-of select="./tei:title[@xml:lang = 'eng']"/>
                    </h6>
                    <xsl:apply-templates/>
                </li>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:title"> </xsl:template>
    <xsl:template match="tei:figure">
        <xsl:for-each select="./tei:graphic">
            <xsl:variable name="source" select="data(tokenize(@url, '/'))"/>
            <div class="img-notes">
                <img class="tei-xml-images">
                    <xsl:attribute name="src">
                        <xsl:value-of select="
                                concat(
                                'https://bk-img.acdh-dev.oeaw.ac.at/',
                                $source[last()])"/>
                    </xsl:attribute>
                </img>
            </div>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
</xsl:stylesheet>
