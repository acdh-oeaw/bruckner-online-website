<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget add_script_for_one_dataTable.</h1>
            <p>Contact person: daniel.stoxreiter@oeaw.ac.at</p>
            <p>Applied before the closing html:body tag.</p>
            <p>The template "add_script_for_one_dataTable" containes datatables base css and js needed to load tables.</p>
        </desc>
    </doc>

    <xsl:template name="datatable-base">
        <!-- Jquery 3 and Bootstrap 4 / Buttons, Responsive, Search, Select, -->
        <!-- DataTables stylesheet -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.10.24/af-2.3.5/b-1.7.0/b-html5-1.7.0/b-print-1.7.0/r-2.2.7/sp-1.2.2/sl-1.3.3/datatables.min.css"/>
        <!-- DataTables Script -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.10.24/af-2.3.5/b-1.7.0/b-html5-1.7.0/b-print-1.7.0/r-2.2.7/sp-1.2.2/sl-1.3.3/datatables.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.11.0/b-2.0.0/b-html5-2.0.0/cr-1.5.4/r-2.2.9/sp-1.4.0/datatables.min.js"></script>
    </xsl:template>
</xsl:stylesheet>
