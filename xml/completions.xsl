<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <xsl:output method="xhtml" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="pkp.css"/>
                <title>completions</title>
            </head>
            <body>
                <h1>Completions</h1>
                <table border="0" cellpadding="0" cellspacing="0">
                    <xsl:apply-templates/>
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="//add">
        <xsl:variable name="SpanClass">
            <xsl:choose>
                <xsl:when test="@ana='completion'">
                    <xsl:text>completion</xsl:text>
                </xsl:when>
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
            <!-- add line break -->
            <xsl:when test="@type='break'">
                <span class="layout">/</span>
            </xsl:when>
            <!-- add no line break -->
            <xsl:when test="@type='nobreak'">
                <span class="layout">|</span>
            </xsl:when>
            <!-- add text -->
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

    <xsl:template match="//cb"/>

    <xsl:template match="//corr"/>

    <xsl:template match="//damage">
        <xsl:choose>
            <!-- damage within poem -->
            <xsl:when test="not(@degree='1')">
                <span class="editorial">[<xsl:value-of select="@type"/>]</span>
            </xsl:when>
            <xsl:when test="@degree='1'">
                <!-- damage larger than poem -->
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="top" width="100"/>
                        <td valign="top">
                            <span class="editorial">[<xsl:value-of select="@type"/>]</span>
                        </td>
                    </tr>
                </table>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="//dateline"/>

    <xsl:template match="//del">
        <xsl:variable name="SpanClass">
            <xsl:choose>
                <xsl:when test="@ana='completion'">
                    <xsl:text>completion</xsl:text>
                </xsl:when>
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
            <!-- add line break -->
            <xsl:when test="@type='break'">
                <span class="layout">/</span>
            </xsl:when>
            <!-- add no line break -->
            <xsl:when test="@type='nobreak'">
                <span class="layout">|</span>
            </xsl:when>
            <!-- add text -->
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

    <xsl:template match="//div">
        <xsl:choose>
            <!-- division: not containing poems -->
            <xsl:when test="@type='contents'"/>
            <!--division: containing poems -->
            <xsl:when test="@type='section' or @type='subsection'">
                <xsl:apply-templates/>
            </xsl:when>
            <!--division: poem (not emended) -->
            <xsl:when test="@type='poem' and not(descendant::del[@ana='completion'])"/>
            <!--division: poem (emended) -->
            <!--division: poem (not emended) -->
            <xsl:when test="@type='poem' and descendant::del/note"/>
            <!--division: poem (emended) -->
            <xsl:when test="@type='poem' and descendant::head/del[@ana='completion'] or descendant::title/del[@ana='completion']or descendant::del[@ana='completion']/title or descendant::l/del[@ana='completion']">
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

    <xsl:template match="//epigraph">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//expan"/>

    <xsl:template match="//gap">
        <span class="editorial">[<xsl:value-of select="@reason"/>]</span>
    </xsl:template>

    <!-- head -->
    <xsl:template match="//head">
        <xsl:choose>
            <!-- not poem -->
            <xsl:when test="@type!='poem'"/>
            <!-- not completed-->
            <xsl:when test="@type='poem' and not(descendant::del[@ana='completion']) and not(descendant::add[@ana='completion'])"/>
           
                            <!-- completion in process-->
                 <xsl:when test="@type='poem' and descendant::del[@ana='completion']">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="top" width="100">
                            <xsl:if test="not(descendant::title[@type])"> <span class="completion"><span class="small-caps">title[inc]</span></span></xsl:if>
                            <xsl:if test="descendant::title[@type]"> <span class="completion"><span class="small-caps">subtitle[inc]</span></span></xsl:if>
                                                    </td>
                        <td valign="top">
                            <xsl:apply-templates/>
                        </td>
                    </tr>
                </table>
                 </xsl:when>
            
            <!-- completion final-->
                 <xsl:when test="@type='poem' and descendant::add[@ana='completion' and not(descendant::del[@ana='completion'])]">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="top" width="100">
                            <xsl:if test="not(descendant::title[@type])"> <span class="small-caps">title</span></xsl:if>
                            <xsl:if test="descendant::title[@type]"> <span class="small-caps">subtitle</span></xsl:if>
                                                    </td>
                        <td valign="top">
                            <xsl:apply-templates/>
                        </td>
                    </tr>
                </table>
            </xsl:when>
            
            
               <xsl:otherwise>
                <xsl:message terminate="yes">Found 'head' element with an unexpected value for
                    'type' attribute</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:template>

    <xsl:template match="//item"/>

    <xsl:template match="//l">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top" width="100">
                    <xsl:choose>
                        <!-- numbering for line in process of revision -->
                        <xsl:when test="descendant::del[@ana='completion']" >
                            <span class="completion">
                                <xsl:value-of select="@n"/><xsl:value-of select="@part"/>[inc]
                            </span>
                        </xsl:when>
                        <!-- numbering for completed -->
                        <xsl:when test="descendant::add[@ana='completion'] and not(descendant::del[@ana='completion'])">
                            <span class="small-caps"><xsl:value-of
                                        select="@n"/><xsl:value-of select="@part" /></span>
                        </xsl:when>
                    </xsl:choose>
                </td>
                <td valign="top">
                    <xsl:choose>
                        <!--line flush left -->
                        <xsl:when test="not(@rend) and descendant::del[@ana='completion'] or descendant::add[@ana='completion']">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <!-- line not flush left-->
                        <xsl:when test="@rend and descendant::del[@ana='completion'] or descendant::add[@ana='completion']">
                            <span class="layout">[<xsl:value-of select="@rend"/>]</span>
                            <xsl:apply-templates/>
                        </xsl:when>
                        <!--line spacing in process of revision (initial) -->
                        <xsl:when
                            test="descendant::del[@ana='completion'] and not(descendant::add[@ana='completion']) and not(descendant::text()[normalize-space()])">
                            <span class="completion">&lt;</span>
                            <span class="layout">
                                <span class="small-caps">[<xsl:value-of select="@rend"/>]</span>
                            </span>
                            <span class="completion">&gt;</span>
                        </xsl:when>
                        <!-- 2 line spacing in process of revision (intermediate) -->
                        <xsl:when
                            test="descendant::del[@ana='completion'] and descendant::add[@ana='completion'] and not(descendant::text()[normalize-space()])">
                            <span class="completion">&lt;[</span>
                            <span class="layout">
                                <span class="small-caps">[<xsl:value-of select="@rend"/>]</span>
                            </span>
                            <span class="completion">]&gt;</span>
                        </xsl:when>
                        <!-- line spacing completed -->
                        <xsl:when test="not(descendant::del[@ana='completion']) and descendant::add[@ana='completion'] and not(descendant::text()[normalize-space()])">
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

    <xsl:template match="//lb"/>

    <xsl:template match="//lg">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//list">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//note"/>

    <xsl:template match="//orig">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//pb"/>

    <xsl:template match="//q">
        <xsl:choose>
            <!-- quotes: single ('...')-->
            <xsl:when test="@rend='sq'">'<xsl:apply-templates/>'</xsl:when>
            <!-- quotes: single left ('...) -->
            <xsl:when test="@rend='lsq'">'<xsl:apply-templates/></xsl:when>
            <!-- quotes: (...') -->
            <xsl:when test="@rend='rsq'">
                <xsl:apply-templates/>'</xsl:when>
            <!-- quotes:("...") -->
            <xsl:when test="@rend='dq'">"<xsl:apply-templates/>"</xsl:when>
            <!-- quotes:("...) -->
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

    <xsl:template match="//ref"/>

    <xsl:template match="//reg"/>

      <!-- sic -->
    <xsl:template match="//sic">
        <xsl:choose>
            <xsl:when test="not(@ana='illegible')"><xsl:apply-templates/><span class="editorial">[sic]</span></xsl:when>
             <xsl:when test="@ana"><span class="editorial"><xsl:apply-templates/></span></xsl:when>
        <xsl:otherwise>
                <xsl:message terminate="yes">Found a 'sic' element with an unexpected value for 'ana'
                    attribute</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:template>

    <xsl:template match="//sp">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//space">&#160;&#160;&#160;&#160;&#160;&#160;</xsl:template>

    <xsl:template match="//speaker">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top" width="100">
                    <xsl:choose>
                        <!-- speaker not revised-->
                        <xsl:when test="not(@ana)"/>
                        <!-- speaker revision in process-->
                        <xsl:when test="@ana and not(@select)">
                            <span class="revision"><span class="small-caps"
                                    >speaker</span>(<xsl:value-of select="@ana"/>)</span>
                        </xsl:when>
                        <!-- speaker revision final -->
                        <xsl:when test="@ana and @select">
                            <span class="small-caps">speaker</span>
                            <span class="revision">(<xsl:value-of select="@ana"/>)</span>
                        </xsl:when>
                    </xsl:choose>
                </td>
                <td valign="top">
                    <xsl:choose>
                        <xsl:when test="@ana">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:when test="not(@ana)"/>
                    </xsl:choose>
                </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="//teiHeader"/>

     <!-- title -->

    <xsl:template match="title">
        <xsl:choose>
            <!-- title: plain-->
            <xsl:when test="not(@rend)">
                
                <xsl:apply-templates/>
            </xsl:when>
            <!-- title: center plain-->
            <xsl:when test="@rend='center'">
                
                <span class="layout">[center]</span>
                <xsl:apply-templates/>
            </xsl:when>
            <!-- title: sq-->
            <xsl:when test="@rend='sq'">
                 '<xsl:apply-templates/>' </xsl:when>
            <!-- title: center sq-->
            <xsl:when test="@rend='center sq'">
                <span class="layout">[center]</span>"<xsl:apply-templates/>" </xsl:when>
            <!-- title: dq-->
            <xsl:when test="@rend='dq'">
                 "<xsl:apply-templates/>" </xsl:when>
            <!-- title: center dq-->
            <xsl:when test="@rend='center dq'">
                <span class="layout">[center]</span>"<xsl:apply-templates/>" </xsl:when>
            <!-- title: underlined-->
            <xsl:when test="@rend='underline'">
                
                <span class="underline">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <!-- title: center underlined-->
            <xsl:when test="@rend='center underline'">
                
                <span class="layout">[center]</span>
                <span class="underline">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <!-- title: underline sq-->
            <xsl:when test="@rend='sq'">
                 '<span class="underline"><xsl:apply-templates/></span>' </xsl:when>
            <!-- title: center underline sq-->
            <xsl:when test="@rend='center underline sq'">
                <span class="layout">[center]</span>"<span class="underline"
                    ><xsl:apply-templates/></span>" </xsl:when>
            <!-- title: undeline dq-->
            <xsl:when test="@rend='underline dq'">
                 "<span class="underline"><xsl:apply-templates/></span>" </xsl:when>
            <!-- title: center underline dq-->
            <xsl:when test="@rend='center underline dq'">
                <span class="layout">[center]</span>"<span class="underline"
                    ><xsl:apply-templates/></span>" </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">Found a 'title' element with an unexpected value for
                    'type' or 'rend' attribute</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="//titlePage">
        <br/>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//titlePart"/>

    <xsl:template match="//trailer">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top" width="100">
                    <xsl:choose>
                        <!-- numbering for trailer unaltered -->
                        <xsl:when test="not(@ana)"/>
                        <!-- numbering for trailer in process of revision -->
                        <xsl:when test="@ana and not(@select)">
                            <span class="small-caps">trailer</span>
                            <xsl:value-of select="@part"/>
                            <span class="revision">(<xsl:value-of select="@ana"/>)</span>
                        </xsl:when>
                        <!-- numbering for trailer revised -->
                        <xsl:when test="@ana and @select">
                            <span class="revision"><span class="small-caps"
                                    >trailer</span><xsl:value-of select="@part"/>(<xsl:value-of
                                    select="@ana"/>)</span>
                        </xsl:when>
                    </xsl:choose>
                </td>
                <td valign="top">
                    <xsl:choose>
                        <!-- trailer not revised -->
                        <xsl:when test="not(@ana)"/>
                        <!-- trailer flush left -->
                        <xsl:when test="@ana and not(@rend)">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <!-- trailer center-->
                        <xsl:when test="@ana and @rend">
                            <span class="layout">[<xsl:value-of select="@rend='center'"/>]</span>
                            <xsl:apply-templates/>
                        </xsl:when>
                    </xsl:choose>
                </td>
            </tr>
        </table>
    </xsl:template>

</xsl:stylesheet>
