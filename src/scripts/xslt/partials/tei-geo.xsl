<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:foo="foo.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:my="http://test.org/" exclude-result-prefixes="#all" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"/>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget tei-geo.</h1>
            <p>Contact person: daniel.stoxreiter@oeaw.ac.at</p>
            <p>Applied in html:body.</p>
            <p>The template "tei-geo" tests wheter a tei/xml geo tag exists.</p>
            <p>If a geo tag is found a div container is created that is used to create a leaflet.js map.</p>
            <p>This template requires the "add_script_for_leaflet_map" template.</p>
        </desc>
    </doc>

    <xsl:template name="add_map_container">
        <div class="container" id="leaflet-map-one" style="display:none;">
        </div>

    </xsl:template>
</xsl:stylesheet>
