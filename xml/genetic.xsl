<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <xsl:output method="xhtml" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="pkp.css"/>
                <title>genetic</title>
            </head>
            <body>
                <h1>Genetic</h1>
                <table border="0" cellpadding="0" cellspacing="0">
                    <xsl:apply-templates/>
                </table>
            </body>
        </html>
    </xsl:template>

    <!-- add -->
    <xsl:template match="//add">
        <xsl:variable name="SpanClass">
            <xsl:choose>
                <!-- completion span class -->
                <xsl:when test="@ana='completion'">
                    <xsl:text>completion</xsl:text>
                </xsl:when>
                <!-- revision span clas -->
                <xsl:when test="not(@ana)">
                    <xsl:text>revision</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message terminate="yes">Found an 'add' element with an unexpected value for
                        'ana' attribute</xsl:message>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:value-of select="$SpanClass"/>
            </xsl:attribute>
            <xsl:text>[</xsl:text>
        </xsl:element>
        <xsl:choose>
            <!-- line break -->
            <xsl:when test="@type='break'">
                <span class="layout">/</span>
            </xsl:when>
            <!-- no line break -->
            <xsl:when test="@type='nobreak'">
                <span class="layout">|</span>
            </xsl:when>
            <!-- text -->
            <xsl:when test="not(@type)">
                <xsl:apply-templates/>
            </xsl:when>
        </xsl:choose>
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:value-of select="$SpanClass"/>
            </xsl:attribute>
            <xsl:text>]</xsl:text>
        </xsl:element>
    </xsl:template>

    <!-- body -->
    <xsl:template match="body">
        <br/>
        <xsl:apply-templates/>
    </xsl:template>

    <!-- cb -->
    <xsl:template match="//cb">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top" width="100"/>
                <td valign="top">
                    <span class="layout">[column <span class="small-caps"><xsl:value-of select="@n"
                            /></span>]</span>
                </td>
            </tr>
        </table>
    </xsl:template>

    <!-- corr -->
    <xsl:template match="//corr"/>

    <!-- damage -->
    <xsl:template match="//damage">
        <xsl:choose>
            <!-- within  poem -->
            <xsl:when test="not(@degree='1')">
                <span class="editorial">[<xsl:value-of select="@type"/>]</span>
            </xsl:when>
            <!-- outside poem -->
            <xsl:when test="@degree='1'">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="top" width="100"> </td>
                        <td valign="top">
                            <span class="editorial">[<xsl:value-of select="@type"/>]</span>
                        </td>
                    </tr>
                </table>
            </xsl:when>
        </xsl:choose>
    </xsl:template>


    <!-- dateline -->
    <xsl:template match="//dateline">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top" width="100">
                    <xsl:choose>
                        <!-- numbering for unaltered -->
                        <xsl:when test="not(@ana) and not(descendant::del) and not(descendant::add)"/>
                        <!-- numbering for process of completion -->
                        <xsl:when test="not(@ana) and descendant::del[@ana]">
                            <span class="completion">dateline[[inc]</span>
                        </xsl:when>
                        <!-- numbering for completed -->
                        <xsl:when
                            test="not(@ana) and not(descendant::del[@ana]) and descendant::add[@ana='completion']">
                            <span class="small-caps">dateline</span>
                        </xsl:when>
                        <!-- numbering for process of revision -->
                        <xsl:when test="@ana and not(@select)">
                            <span class="revision"><span class="small-caps"
                                    >dateline</span>(<xsl:value-of select="@ana"/>)</span>
                        </xsl:when>
                        <!-- numbering for revised -->
                        <xsl:when test="@ana and @select">
                            <span class="small-caps">dateline</span>
                            <span class="revision">(<xsl:value-of select="@ana"/>)</span>
                        </xsl:when>
                    </xsl:choose>
                </td>
                <td valign="top">
                    <span class="nontext">{<xsl:apply-templates/>}</span>
                </td>
            </tr>
        </table>
    </xsl:template>

    <!-- del -->
    <xsl:template match="//del">
        <xsl:variable name="SpanClass">
            <xsl:choose>
                <!-- completion span class -->
                <xsl:when test="@ana='completion'">
                    <xsl:text>completion</xsl:text>
                </xsl:when>
                <!-- revision span class -->
                <xsl:when test="not(@ana)">
                    <xsl:text>revision</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message terminate="yes">Found an 'add' element with an unexpected value for
                        'del' attribute</xsl:message>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:value-of select="$SpanClass"/>
            </xsl:attribute>
            <xsl:text>&lt;</xsl:text>
        </xsl:element>
        <xsl:choose>
            <!-- line break -->
            <xsl:when test="@type='break'">
                <span class="layout">/</span>
            </xsl:when>
            <!-- no line break -->
            <xsl:when test="@type='nobreak'">
                <span class="layout">|</span>
            </xsl:when>
            <!-- text -->
            <xsl:when test="not(@type)">
                <xsl:apply-templates/>
            </xsl:when>
        </xsl:choose>
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:value-of select="$SpanClass"/>
            </xsl:attribute>
            <xsl:text>&gt;</xsl:text>
        </xsl:element>
    </xsl:template>

    <!-- div -->
    <xsl:template match="//div">
        <xsl:choose>
            <!-- not poem -->
            <xsl:when test="not(@type='poem')">
                <br/>
                <xsl:apply-templates/>
            </xsl:when>
            <!-- poem -->
            <xsl:when test="@type='poem'">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="top">&#160;</td>
                    </tr>
                </table>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="top" width="100"/>
                        <td valign="top">
                            <span class="editorial">***</span>
                        </td>
                    </tr>
                </table>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="top"/>
                        <td valign="top">
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
            <!-- underline -->
            <xsl:when test="@rend='underline'">
                <span class="underline">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <!-- italic -->
            <xsl:when test="@rend='italic'">
                <span class="italic">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <!-- bold -->
            <xsl:when test="@rend='bold'">
                <span class="bold">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <!-- small caps -->
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
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top" width="100">
                    <xsl:choose>
                        <!-- unaltered -->
                        <xsl:when
                            test="not(@ana) and not(descendant::add[@ana='completion']) and not(descendant::del[@ana='completion'])"> </xsl:when>
                        <!-- in process of completion -->
                        <xsl:when
                            test="descendant::del[@ana='completion'] and not(descendant::add[@ana='completion'])">
                            <xsl:if test="descendant::title[@type='subtitle']">
                                <span class="completion"><span class="small-caps">subtitle[inc]</span></span>
                            </xsl:if>
                            <xsl:if test="not(descendant::title[@type='subtitle'])">
                                <span class="completion"><span class="small-caps">title[inc]</span>]</span>
                            </xsl:if>
                        </xsl:when>
                        <!--  completed -->
                        <xsl:when
                            test="not(@ana) and descendant::add[@ana='completion'] and not(descendant::del[@ana='completion'])">
                            <xsl:if test="descendant::title[@type='subtitle']"><span class="small-caps">subtitle</span></xsl:if>
                            <xsl:if test="not(descendant::title[@type='subtitle'])"><span class="small-caps">title</span></xsl:if>
                        </xsl:when>
                        <!-- in process of revision -->
                        <xsl:when test="@ana and not(@select='final')">
                            <xsl:if test="descendant::title[@type='subtitle']">
                                <span class="revision"><span class="small-caps">subtitle</span>(<xsl:value-of select="@ana"
                                    />)</span>
                            </xsl:if>
                            <xsl:if test="not(descendant::title[@type='subtitle'])">
                                <span class="revision"><span class="small-caps">title</span>(<xsl:value-of select="@ana"/>)</span>
                            </xsl:if>
                        </xsl:when>
                        <!-- revised -->
                        <xsl:when test="@ana and@select='final'">
                            <xsl:if test="descendant::title[@type='subtitle']"><span class="small-caps">subtitle</span><span
                                    class="revision">(<xsl:value-of select="@ana"/>)</span></xsl:if>
                            <xsl:if test="not(descendant::title[@type='subtitle'])"><span class="small-caps">title</span><span
                                    class="revision">(<xsl:value-of select="@ana"/>)</span></xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:message terminate="yes">Found 'note' element with an unexpected
                                value for 'type' attribute</xsl:message>
                        </xsl:otherwise>
                    </xsl:choose>
                </td>
                <td valign="top">
                    <xsl:apply-templates/>
                </td>
            </tr>
        </table>
    </xsl:template>

    <!-- item -->
    <xsl:template match="//item">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top" width="100">
                    <xsl:choose>
                        <!-- numbering for unaltered -->
                        <xsl:when test="not(@ana) and not(descendant::del) and not(descendant::add)"/>
                        <!-- numbering for in process of completion -->
                        <xsl:when test="not(@ana) and descendant::del[@ana]">
                            <span class="completion">item[[inc]</span>
                        </xsl:when>
                        <!-- numbering for completed -->
                        <xsl:when
                            test="not(@ana) and not(descendant::del[@ana]) and descendant::add[@ana='completion']">
                            <span class="small-caps">item</span>
                        </xsl:when>
                        <!-- numbering for process of revision -->
                        <xsl:when test="@ana and not(@select)">
                            <span class="revision"><span class="small-caps"
                                    >item</span>(<xsl:value-of select="@ana"/>)</span>
                        </xsl:when>
                        <!-- numbering for revised -->
                        <xsl:when test="@ana and @select">
                            <span class="small-caps">item</span>
                            <span class="revision">(<xsl:value-of select="@ana"/>)</span>
                        </xsl:when>
                    </xsl:choose>
                </td>
                <td valign="top">
                    <xsl:apply-templates/>
                </td>
            </tr>
        </table>
    </xsl:template>

    <!-- l -->
    <xsl:template match="//l">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top" width="100">
                    <xsl:choose>
                        <!-- numbering for unaltered or completed -->
                        <xsl:when test="not(@ana) and not(descendant::del[@ana])">
                            <span class="small-caps">
                                <xsl:value-of select="@n"/>
                            </span>
                            <xsl:value-of select="@part"/>
                        </xsl:when>
                        <!-- numbering for process of completion -->
                        <xsl:when test="not(@ana) and descendant::del[@ana]">
                            <span class="completion"><span class="small-caps"><xsl:value-of
                                        select="@n"/></span><xsl:value-of select="@part"
                                />[inc]</span>
                        </xsl:when>
                        <!-- numbering for process of revision -->
                        <xsl:when test="@ana and @select">
                            <span class="small-caps">
                                <xsl:value-of select="@n"/>
                            </span>
                            <xsl:value-of select="@part"/>
                            <span class="revision">(<xsl:value-of select="@ana"/>)</span>
                        </xsl:when>
                        <!-- numbering for revised -->
                        <xsl:when test="@ana and not(@select)">
                            <span class="revision"><span class="small-caps"><xsl:value-of
                                        select="@n"/></span><xsl:value-of select="@part"
                                    />(<xsl:value-of select="@ana"/>)</span>
                        </xsl:when>
                    </xsl:choose>
                </td>
                <td valign="top">
                    <xsl:choose>
                        <!-- flush left -->
                        <xsl:when test="not(@rend) and descendant::text()">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <!-- not flush left -->
                        <xsl:when test="@rend and descendant::text()">
                            <span class="layout">[<xsl:value-of select="@rend"/>]</span>
                            <xsl:apply-templates/>
                        </xsl:when>
                        <!-- empty -->
                        <xsl:when test="not(@rend) and not(descendant::text()[normalize-space()])">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <!-- line spacing process of completion (initial) -->
                        <xsl:when
                            test="@rend and not(@ana) and descendant::del[@ana] and not(descendant::add[@ana]) and not(descendant::text()[normalize-space()])">
                            <span class="completion">&lt;</span>
                            <span class="layout">
                                <span class="small-caps">[<xsl:value-of select="@rend"/>]</span>
                            </span>
                            <span class="completion">&gt;</span>
                        </xsl:when>
                        <!-- line spacing process of completion (intermediate) -->
                        <xsl:when
                            test="@rend and not(@ana) and descendant::del[@ana] and descendant::add[@ana] and not(descendant::text()[normalize-space()])">
                            <span class="completion">&lt;[</span>
                            <span class="layout">
                                <span class="small-caps">[<xsl:value-of select="@rend"/>]</span>
                            </span>
                            <span class="completion">]&gt;</span>
                        </xsl:when>
                        <!-- line spacing completed -->
                        <xsl:when
                            test="@rend and not(@ana)and not(descendant::del[@ana]) and descendant::add[@ana] and not(descendant::text()[normalize-space()])">
                            <span class="completion">[</span>
                            <span class="layout">
                                <span class="small-caps">[<xsl:value-of select="@rend"/>]</span>
                            </span>
                            <span class="completion">]</span>
                        </xsl:when>
                        <!-- line spacing process of revision (initial) -->
                        <xsl:when
                            test=" @rend and @ana and not(@select) and not(descendant::add[not(@ana)]) and not(descendant::text()[normalize-space()])">
                            <span class="revision">&lt;</span>
                            <span class="layout">
                                <span class="small-caps">[<xsl:value-of select="@rend"/>]</span>
                            </span>
                            <span class="revision">&gt;</span>
                        </xsl:when>
                        <!-- line spacing process of revision (intermediate) -->
                        <xsl:when
                            test="@ana and not(@select) and  @rend and descendant::add[not(@ana)] and not(descendant::text()[normalize-space()])">
                            <span class="revision">&lt;[</span>
                            <span class="layout">
                                <span class="small-caps">[<xsl:value-of select="@rend"/>]</span>
                            </span>
                            <span class="revision">]&gt;</span>
                        </xsl:when>
                        <!-- line spacing revised -->
                        <xsl:when
                            test="@rend and @ana and @select  and not(descendant::text()[normalize-space()])">
                            <span class="revision">[</span>
                            <span class="layout">
                                <span class="small-caps">[<xsl:value-of select="@rend"/>]</span>
                            </span>
                            <span class="revision">]</span>
                        </xsl:when>
                    </xsl:choose>
                </td>
            </tr>
        </table>
    </xsl:template>

    <!-- lb -->
    <xsl:template match="//lb">
        <span class="layout">/</span>
    </xsl:template>

    <!-- lg -->
    <xsl:template match="//lg">
        <xsl:choose>
            <!-- line space added -->
            <xsl:when test="@ana='revised'">
                <xsl:apply-templates/>
            </xsl:when>
            <!-- no line space added -->
            <xsl:when test="not(@ana)">
                <br/>
                <xsl:apply-templates/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- list -->
    <xsl:template match="//list">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- note -->
    <xsl:template match="note">
        <xsl:choose>
            <!-- to be indented -->
            <xsl:when
                test="parent::body or parent::div or parent::epigraph or parent::front or parent::lg or parent::titlePage">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="top" width="100"> </td>
                        <td valign="top">
                            <!-- authorial -->
                            <xsl:if test="not(@type)">
                                <span class="nontext">{<xsl:apply-templates/>}</span>
                            </xsl:if>
                            <!-- editorial -->
                            <xsl:if test="@type='editorial'">
                                <span class="editorial">[<xsl:apply-templates/>]</span>
                            </xsl:if>
                        </td>
                    </tr>
                </table>
            </xsl:when>
            <!--  already indented -->
            <xsl:when test="parent::head or parent::item or parent::l or parent::titlePart">
                <!-- authorial -->
                <xsl:if test="not(@type)">
                    <span class="nontext">{<xsl:apply-templates/>}</span>
                </xsl:if>
                <!-- editorial -->
                <xsl:if test="@type='editorial'">
                    <span class="editorial">[<xsl:apply-templates/>]</span>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">Found 'note' element with an unexpected value for
                    'type' attribute</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!-- orig -->
    <xsl:template match="//orig">
        <xsl:choose>
            <!-- not untitled-->
            <xsl:when test="not(@ana)">
                <xsl:apply-templates/>
            </xsl:when>
            <!-- untitled -->
            <xsl:when test="@ana='untitled'">
                <span class="editorial">[untitled]</span>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- pb -->
    <xsl:template match="pb">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <xsl:choose>
                    <!-- not within line -->
                    <xsl:when test="parent::body or parent::div or parent::front or parent::lg">
                        <td valign="top" width="100"/>
                    </xsl:when>
                    <!-- within line -->
                    <xsl:when test="parent::l"/>
                </xsl:choose>
                <td valign="top">
                    <span class="pagedivision">——————————————————</span>
                </td>
            </tr>
            <tr>
                <xsl:choose>
                    <!-- not within line -->
                    <xsl:when test="parent::body or parent::div or parent::front or parent::lg">
                        <td valign="top"/>
                    </xsl:when>
                    <!--within line -->
                    <xsl:when test="parent::l"/>
                </xsl:choose>
                <td valign="top">
                    <span class="pagebreak">[<xsl:value-of select="@rend"/>]</span>
                </td>
            </tr>
        </table>
    </xsl:template>

    <!-- q -->
    <xsl:template match="//q">
        <xsl:choose>
            <!-- '...' -->
            <xsl:when test="@rend='sq'">'<xsl:apply-templates/>'</xsl:when>
            <!-- '... -->
            <xsl:when test="@rend='lsq'">'<xsl:apply-templates/></xsl:when>
            <!-- ...' -->
            <xsl:when test="@rend='rsq'">
                <xsl:apply-templates/>'</xsl:when>
            <!-- "..." -->
            <xsl:when test="@rend='dq'">"<xsl:apply-templates/>"</xsl:when>
            <!--  "... -->
            <xsl:when test="@rend='ldq'">"<xsl:apply-templates/></xsl:when>
            <!-- ..." -->
            <xsl:when test="@rend='rdq'">
                <xsl:apply-templates/>"</xsl:when>
            <!--  ... -->
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
    <xsl:template match="//reg"/>

    <!-- sic -->
    <xsl:template match="//sic">
        <xsl:choose>
            <!-- not illegible -->
            <xsl:when test="not(@ana='illegible')">
                <xsl:apply-templates/>
                <span class="editorial">[sic]</span>
            </xsl:when>
            <!-- illegible -->
            <xsl:when test="@ana">
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
        <br/>
        <xsl:apply-templates/>
    </xsl:template>

    <!-- space -->
    <xsl:template match="//space">&#160;&#160;&#160;&#160;&#160;&#160;</xsl:template>

    <!-- speaker -->
    <xsl:template match="//speaker">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top" width="100">
                    <xsl:choose>
                        <!-- unrevised -->
                        <xsl:when test="not(@ana)">
                            <xsl:if
                                test="not(descendant::del[@ana='completion']) and not(descendant:: add[@ana='completion'])"> </xsl:if>
                            <!-- completion in process -->
                            <xsl:if
                                test="descendant::del[@ana='completion'] and  descendant:: add[@ana='completion']">
                                <span class="completion">
                                    <span class="small-caps">speaker[inc]</span>
                                </span>
                            </xsl:if>
                            <!-- completion final -->
                            <xsl:if test="not(descendant::del[@ana='completion']) and descendant::add[@ana='completion']">
                                <span class="small-caps">speaker</span>
                            </xsl:if>
                        </xsl:when>
                        <!-- revised -->
                        <xsl:when test="@ana">
                            <!-- revision in process -->
                            <xsl:if test="not(@select)">
                                <span class="revision"><span class="small-caps"
                                        >speaker</span>(<xsl:value-of select="@ana"/>)</span>
                            </xsl:if>
                            <!-- revision final -->
                            <xsl:if test="@select">
                                <span class="small-caps">speaker</span>
                                <span class="revision">(<xsl:value-of select="@ana"/>)</span>
                            </xsl:if>
                        </xsl:when>
                    </xsl:choose>
                </td>
                <td valign="top">
                    <xsl:apply-templates/>
                </td>
            </tr>
        </table>
    </xsl:template>

    <!-- teiHeader -->
    <xsl:template match="//teiHeader"/>

    <!-- title -->
    <xsl:template match="title">
        <xsl:choose>
            <!-- plain -->
            <xsl:when test="not(@rend)">
                <xsl:apply-templates/>
            </xsl:when>
            <!-- center -->
            <xsl:when test="@rend='center'">
                <span class="layout">[center]</span>
                <xsl:apply-templates/>
            </xsl:when>
            <!--sq -->
            <xsl:when test="@rend='sq'"> '<xsl:apply-templates/>' </xsl:when>
            <!-- center sq -->
            <xsl:when test="@rend='center sq'">
                <span class="layout">[center]</span>'<xsl:apply-templates/>'</xsl:when>
            <!--dq -->
            <xsl:when test="@rend='dq'"> "<xsl:apply-templates/>" </xsl:when>
            <!-- center dq -->
            <xsl:when test="@rend='center dq'">
                <span class="layout">[center]</span>"<xsl:apply-templates/>" </xsl:when>
            <!-- underline -->
            <xsl:when test="@rend='underline'">
                <span class="underline">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <!--center underline -->
            <xsl:when test="@rend='center underline'">
                <span class="layout">[center]</span>
                <span class="underline">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <!-- underline sq-->
            <xsl:when test="@rend='underline sq'"> '<span class="underline"
                    ><xsl:apply-templates/></span>'</xsl:when>
            <!--center underline sq -->
            <xsl:when test="@rend='center underline sq'"><span class="layout">[center]</span>'<span
                    class="underline"><xsl:apply-templates/></span>' </xsl:when>
            <!-- underline dq-->
            <xsl:when test="@rend='underline dq'"> "<span class="underline"
                    ><xsl:apply-templates/></span>"</xsl:when>
            <!--center underline dq -->
            <xsl:when test="@rend='center underline dq'"><span class="layout">[center]</span>"<span
                    class="underline"><xsl:apply-templates/></span>" </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">Found a 'title' element with an unexpected value for
                    'type' or 'rend' attribute</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- titlePage -->
    <xsl:template match="//titlePage">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top" width="100"/>
            </tr>
        </table>
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top"/>
                <td valign="top">
                    <xsl:apply-templates/>
                </td>
            </tr>
        </table>
    </xsl:template>

    <!--titlePart -->
    <xsl:template match="//titlePart">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top" width="100">
                    <xsl:choose>
                        <!-- numbering for unrevised -->
                        <xsl:when test="not(@ana)">
                            <!-- unaltered -->
                            <xsl:if
                                test="not(descendant::del[@ana='completion']) and not(descendant::add[@ana='completion'])"/>
                            <!-- process of completion -->
                            <xsl:if
                                test="descendant::del[@ana='completion'] and not(descendant::add[@ana='completion']) or descendant::del[@ana='completion'] and descendant::add[@ana='completion']">
                                <span class="completion"><span class="small-caps"
                                    >title[inc]</span></span>
                            </xsl:if>
                            <!-- completed -->
                            <xsl:if
                                test="not(descendant::del[@ana='completion']) and descendant::add[@ana='completion']">
                                <span class="small-caps">title</span>
                            </xsl:if>
                        </xsl:when>
                        <!-- numbering for revision -->
                        <xsl:when test="@ana">
                            <!--  process -->
                            <xsl:if test="@select">
                                <span class="small-caps">title</span>
                                <span class="revision">(<xsl:value-of select="@ana"/>)</span>
                            </xsl:if>
                            <!-- final -->
                            <xsl:if test="not(@select)">
                                <span class="revision"><span class="small-caps"
                                        >title</span>(<xsl:value-of select="@ana"/>)</span>
                            </xsl:if>
                        </xsl:when>
                    </xsl:choose>
                </td>
                <td valign="top">
                    <xsl:choose>
                        <!-- plain -->
                        <xsl:when test="not(@rend)">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <!-- center -->
                        <xsl:when test="@rend='center'">
                            <span class="layout">[center]</span>
                            <xsl:apply-templates/>
                        </xsl:when>
                        <!--sq -->
                        <xsl:when test="@rend='sq'"> '<xsl:apply-templates/>' </xsl:when>
                        <!-- center sq -->
                        <xsl:when test="@rend='center sq'">
                            <span class="layout">[center]</span>'<xsl:apply-templates/>'</xsl:when>
                        <!--dq -->
                        <xsl:when test="@rend='dq'"> "<xsl:apply-templates/>" </xsl:when>
                        <!-- center dq -->
                        <xsl:when test="@rend='center dq'">
                            <span class="layout">[center]</span>"<xsl:apply-templates/>" </xsl:when>
                        <!-- underline -->
                        <xsl:when test="@rend='underline'">
                            <span class="underline">
                                <xsl:apply-templates/>
                            </span>
                        </xsl:when>
                        <!--center underline -->
                        <xsl:when test="@rend='center underline'">
                            <span class="layout">[center]</span>
                            <span class="underline">
                                <xsl:apply-templates/>
                            </span>
                        </xsl:when>
                        <!-- underline sq-->
                        <xsl:when test="@rend='underline sq'"> '<span class="underline"
                                ><xsl:apply-templates/></span>'</xsl:when>
                        <!--center underline sq -->
                        <xsl:when test="@rend='center underline sq'"><span class="layout"
                                >[center]</span>'<span class="underline"
                                ><xsl:apply-templates/></span>' </xsl:when>
                        <!-- underline dq-->
                        <xsl:when test="@rend='underline dq'"> "<span class="underline"
                                ><xsl:apply-templates/></span>"</xsl:when>
                        <!--center underline dq -->
                        <xsl:when test="@rend='center underline dq'"><span class="layout"
                                >[center]</span>"<span class="underline"
                                ><xsl:apply-templates/></span>" </xsl:when>
                        <xsl:otherwise>
                            <xsl:message terminate="yes">Found a 'titlePart' element with an
                                unexpected value for 'type' or 'rend' attribute</xsl:message>
                        </xsl:otherwise>
                    </xsl:choose>
                </td>
            </tr>
        </table>
    </xsl:template>

    <!-- trailer -->
    <xsl:template match="trailer">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="100" valign="top">
                    <xsl:choose>
                        <!-- not changed -->
                        <xsl:when test="not(@ana)">
                            <xsl:if
                                test="not(descendant::del[@ana='completion']) and not(descendant::add[ana='completion'])"/>
                            <!-- in process of completion -->
                            <xsl:if
                                test="descendant::del[@ana='completion'] and descendant::add[@ana='completion'] or descendant::del[@ana='completion'] and not(descendant::add[@ana='completion'])">
                                <span class="completion">trailer[inc]</span>
                            </xsl:if>
                            <!--  completed -->
                            <xsl:if
                                test="not(descendant::del[@ana='completion']) and descendant::add[@ana='completion']">
                                <span class="small-caps">trailer</span>
                            </xsl:if>
                        </xsl:when>
                        <!-- in process of revision-->
                        <xsl:when test="@ana">
                            <xsl:if test="not(@select='final')">
                                <span class="revision"><span><span class="small-caps"
                                        >trailer</span></span>(<xsl:value-of select="@ana"/>)</span>
                            </xsl:if>
                            <!-- revised -->
                            <xsl:if test="@select='final'">
                                <span class="small-caps">trailer</span>
                                <span class="revision"><span/>(<xsl:value-of select="@ana"/>)</span>
                            </xsl:if>
                        </xsl:when>
                    </xsl:choose>
                </td>
                <td valign="top">
                    <xsl:choose>
                        <!-- center -->
                        <xsl:when test="not(@rend='center')"/>
                        <!-- flush left -->
                        <xsl:when test="@rend='center'">
                            <span class="layout">[center]</span>
                        </xsl:when>
                        <xsl:otherwise><xsl:message terminate="yes"/>Found a "trailer" element with
                            an unexpected valuer for "rend" or "select" attribute</xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates/>
                </td>
            </tr>
        </table>
    </xsl:template>

</xsl:stylesheet>
