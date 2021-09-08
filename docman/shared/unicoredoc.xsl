<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>

<!--############################################################################
    XSLT Stylesheet DocBook -> LaTeX 
    ############################################################################ -->

 <!-- TOC links in the titles, and in blue. -->
  <xsl:param name="latex.hyperparam">colorlinks,linkcolor=blue,pdfstartview=FitH</xsl:param>
  <xsl:param name="doc.publisher.show">1</xsl:param>
  <xsl:param name="doc.lot.show"></xsl:param>
  <xsl:param name="term.breakline">1</xsl:param>
  <xsl:param name="doc.collab.show">0</xsl:param>
  <xsl:param name="doc.section.depth">3</xsl:param>
  <xsl:param name="table.in.float">0</xsl:param>
  <xsl:param name="monoseq.hyphenation">0</xsl:param>
  <xsl:param name="latex.output.revhistory">1</xsl:param>
  <xsl:param name="doc.toc.show">1</xsl:param>

  <xsl:param name="component.version">?.?.?</xsl:param>

<!-- Implement highlighting text with colored background -->
  <xsl:template  match="phrase[@role='highlight:green']">
    <xsl:text>\fcolorbox{black}{markergreen}{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <!--
    Override default literallayout template.
    See `./dblatex/dblatex-readme.txt`.
  -->
  <xsl:template match="address|literallayout[@class!='monospaced']">
    <xsl:text>\begin{alltt}</xsl:text>
    <xsl:text>&#10;\normalfont{}&#10;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#10;\end{alltt}</xsl:text>
  </xsl:template>

  <xsl:template match="processing-instruction('asciidoc-pagebreak')">
    <!-- force hard pagebreak, varies from 0(low) to 4(high) -->
    <xsl:text>\pagebreak[4] </xsl:text>
    <xsl:apply-templates />
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="processing-instruction('asciidoc-br')">
    <xsl:text>\newline&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="processing-instruction('asciidoc-hr')">
    <!-- draw a 444 pt line (centered) -->
    <xsl:text>\begin{center}&#10; </xsl:text>
    <xsl:text>\line(1,0){444}&#10; </xsl:text>
    <xsl:text>\end{center}&#10; </xsl:text>
  </xsl:template>


<xsl:template match="revhistory">
  <xsl:if test="$latex.output.revhistory=1">
    <xsl:message>Processing Revision History </xsl:message>
    <xsl:apply-templates/>
  </xsl:if>
</xsl:template>

<xsl:template match="revhistory/revision">
  <xsl:variable name="revnumber" select=".//revnumber"/>
  <xsl:variable name="revdate"   select=".//date"/>
  <xsl:variable name="revremark" select=".//revremark|.//revdescription"/>
  <xsl:variable name="revauthor" select=".//authorinitials|.//author"/>
  
  <xsl:if test="$revnumber">
    <xsl:text>\newcommand{\myrevnumber}{</xsl:text>
    <xsl:apply-templates select="$revnumber"/>
    <xsl:text>}&#10;</xsl:text>
  </xsl:if>
  <xsl:text>\newcommand{\myrevdate}{</xsl:text>
  <xsl:apply-templates select="$revdate"/>
  <xsl:text>}&#10;</xsl:text>
  <xsl:text>\newcommand{\mycomponentversion}{</xsl:text>
  <xsl:value-of select="$component.version"/>
  <xsl:text>}&#10;</xsl:text>
</xsl:template>

<xsl:template match="revision/revnumber">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="revision/date">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="revision/authorinitials">
  <xsl:text>, </xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="revision/authorinitials[1]">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="revision/revremark">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="revision/revdescription">
  <xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>
