<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <xsl:output method="xhtml" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="pkp.css"/>
                <title>regularizations</title>
            </head>
            <body>
                <h1>Regularizations</h1>
                <table border="0" cellpadding="0" cellspacing="0">
                    <xsl:apply-templates/>
                </table>
            </body>
        </html>
    </xsl:template>

    <!-- add -->

    <xsl:template match="//add">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- body -->
    <xsl:template match="body">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- cb -->
    <xsl:template match="//cb"/>

    <!-- corr -->
    <xsl:template match="//corr"/>

    <!-- damage -->
    <xsl:template match="//damage">
        <xsl:choose>
            <!-- damage within poem -->
            <xsl:when test="not(@degree='1')">
                <span class="editorial">[<xsl:value-of select="@type"/>]</span>
            </xsl:when>
            <!-- damage larger than poem -->
            <xsl:when test="@degree='1'"/>
        </xsl:choose>
    </xsl:template>


    <!-- dateline -->
    <xsl:template match="//dateline"/>

    <!-- del -->
    <xsl:template match="//del"/>

    <!-- div -->

    <xsl:template match="//div">
        <xsl:choose>
            <!-- division: not containing poems -->
            <xsl:when test="@type='contents'"/>
            <!-- division: containing poems -->
            <xsl:when test="@type='section' or @type='subsection'">
                <xsl:apply-templates/>
            </xsl:when>
            <!-- division: poem (not emended) -->
            <xsl:when test="@type='poem' and not(descendant::reg)"/>
            <!-- division: poem (emended) -->
            <xsl:when test="@type='poem' and descendant::reg">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>&#160;</td>
                    </tr>
                </table>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="100"/>
                        <td>
                            <span class="bold"><xsl:value-of select="@xml:id"/> (<xsl:value-of
                                    select="@ana"/>)</span>
                        </td>
                    </tr>
                </table>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td/>
                        <td>
                            <xsl:apply-templates/>
                        </td>
                    </tr>
                </table>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- emph -->
    <xsl:template match="//emph">
        <xsl:choose>
            <xsl:when test="@rend='underline'">
                <span class="underline">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend='italic'">
                <span class="italic">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend='bold'">
                <span class="bold">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend='small-caps'">
                <span class="small-caps">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">Found an 'emph' element with an unexpected value for
                    'rend' attribute</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- epigraph -->
    <xsl:template match="//epigraph">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- expan -->
    <xsl:template match="//expan"/>

    <!-- gap -->
    <xsl:template match="//gap">
        <span class="editorial">[<xsl:value-of select="@reason"/>]</span>
    </xsl:template>


    <!-- head -->
    <xsl:template match="//head">
        <xsl:choose>
            <!-- not poem -->
            <xsl:when test="@type!='poem'"/>
            <!-- unregularized -->
            <xsl:when test="not(descendant::reg)"/>
            <!-- regularized -->
            <xsl:when test="@type='poem' and descendant::reg">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="top" width="100">
                            <!-- title -->
                            <xsl:if test="not(descendant::title[@type='subtitle'])">
                                <span class="small-caps">title</span>
                            </xsl:if>
                            <!-- subtitle -->
                            <xsl:if test="descendant::title[@type='subtitle']">
                                <span class="small-caps">subtitle</span>
                            </xsl:if>
                        </td>
                        <td valign="top">
                            <xsl:apply-templates/>
                        </td>
                    </tr>
                </table>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">Found 'head' element with an unexpected value for
                    'type' or ' select' attribute</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!-- item -->
    <xsl:template match="//item"/>

    <!-- l -->
    <xsl:template match="//l[descendant::del]"/>

    <xsl:template match="//l[not(descendant::del)]">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <xsl:choose>
                    <xsl:when test="descendant::reg">
                        <td valign="top" width="100">
                            <xsl:value-of select="@n"/>
                            <xsl:value-of select="@part"/>

                        </td>
                    </xsl:when>
                </xsl:choose>
                <td valign="top">
                    <xsl:choose>
                        <!-- 5 line flush left -->
                        <xsl:when test="not(@rend) and descendant::reg">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <!-- line not flush left -->
                        <xsl:when test="@rend and descendant::reg">
                            <span class="layout">[<xsl:value-of select="@rend"/>]</span>
                            <xsl:apply-templates/>
                        </xsl:when>
                    </xsl:choose>
                </td>
            </tr>
        </table>
    </xsl:template>


    <!-- lb -->

    <!-- line break -->
    <xsl:template match="//lb"/>



    <!-- lg-->
    <xsl:template match="//lg">
        <xsl:apply-templates/>
    </xsl:template>


    <!-- list -->
    <xsl:template match="//list"/>

    <!-- note -->
    <xsl:template match="//note"/>

    <!-- orig -->
    <xsl:template match="//orig">
        <span class="regularization">&lt;</span>
        <xsl:choose>
            <xsl:when test="not(@ana)">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="@ana='untitled'">
                <span class="editorial">[untitled]</span>
            </xsl:when>
        </xsl:choose>
        <span class="regularization">&gt;</span>
    </xsl:template>




    <!-- pb -->
    <xsl:template match="//pb"/>


    <!-- q -->
    <xsl:template match="//q">
        <xsl:choose>
            <!-- quotes: single ('...')-->
            <xsl:when test="@rend='sq'">'<xsl:apply-templates/>'</xsl:when>
            <!-- quotes: single left ('...) -->
            <xsl:when test="@rend='lsq'">'<xsl:apply-templates/></xsl:when>
            <!-- quotes: (...') -->
            <xsl:when test="@rend='rsq'">
                <xsl:apply-templates/>'</xsl:when>
            <!-- quotes: ("...") -->
            <xsl:when test="@rend='dq'">"<xsl:apply-templates/>"</xsl:when>
            <!-- quotes: ("...) -->
            <xsl:when test="@rend='ldq'">"<xsl:apply-templates/></xsl:when>
            <!-- quotes: (...") -->
            <xsl:when test="@rend='rdq'">
                <xsl:apply-templates/>"</xsl:when>
            <!-- quotes: (...) -->
            <xsl:when test="@rend='notq'">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">Found a 'q' element with an unexpected value for 'rend'
                    attribute</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- ref -->
    <xsl:template match="//ref"/>

    <!-- reg -->
    <xsl:template match="//reg">
        <span class="regularization">[</span>
        <xsl:apply-templates/>
        <span class="regularization">]</span>
    </xsl:template>

    <!-- sic -->
    <xsl:template match="//sic">
        <xsl:choose>
            <xsl:when test="not(@ana)">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="@ana='illegible'">
                <span class="editorial">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">Found a 'sic' element with an unexpected value for
                    'ana' attribute</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- sp -->
    <xsl:template match="//sp">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- space -->
    <xsl:template match="//space">&#160;&#160;&#160;&#160;&#160;&#160;</xsl:template>

    <!-- speaker -->
    <xsl:template match="speaker">
        <xsl:choose>
            <xsl:when test="descendant::reg">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="top" width="100">
                            <span class="small-caps">speaker</span>
                        </td>
                        <td valign="top">
                            <xsl:apply-templates/>
                        </td>
                    </tr>
                </table>
            </xsl:when>
            <xsl:when test="not(descendant::reg)"/>
        </xsl:choose>
    </xsl:template>

    <!-- teiHeader -->
    <xsl:template match="//teiHeader"/>


    <!-- title -->

    <xsl:template match="title">
        <xsl:choose>
            <!-- plain-->
            <xsl:when test="not(@rend)">
                <xsl:apply-templates/>
            </xsl:when>
            <!-- center plain-->
            <xsl:when test="@rend='center'">
                <span class="layout">[center]</span>
                <xsl:apply-templates/>
            </xsl:when>
            <!--underlined-->
            <xsl:when test="@rend='underline'">
                <span class="underline">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <!--  center underlined-->
            <xsl:when test="@rend='center underline'">
                <span class="layout">[center]</span>
                <span class="underline">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">Found a 'title' element with an unexpected value
                    for 'type' or 'rend' attribute</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!-- titlePage-->
    <xsl:template match="//titlePage"/>

    <!-- titlePart -->


    <xsl:template match="titlePart"/>


    <!-- trailer -->
    <xsl:template match="//trailer">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <xsl:choose>
                    <xsl:when test="descendant::reg">
                        <td valign="top" width="100">
                            <span class="regularization">trailer</span>
                        </td>
                    </xsl:when>
                </xsl:choose>
                <td valign="top">
                    <xsl:choose>
                        <!-- trailer flush left -->
                        <xsl:when test="not(@rend) and descendant::reg">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <!-- trailer not flush left -->
                        <xsl:when test="@rend and descendant::reg">
                            <span class="layout">[<xsl:value-of select="@rend"/>]</span>
                            <xsl:apply-templates/>
                        </xsl:when>
                    </xsl:choose>
                </td>
            </tr>
        </table>
    </xsl:template>

</xsl:stylesheet>
