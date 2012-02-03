<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <xsl:output method="xhtml" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="pkp.css"/>
                <title>check</title>
            </head>
            <body>
                <h1><check>Check</check></h1>
                <table border="0" cellpadding="0" cellspacing="0">
                    <xsl:apply-templates/>
                </table>
            </body>
        </html>
    </xsl:template>

<xsl:template match="abbr | byline | dateline | del | div[@type='contents'] | div[@type='notes'] | head[@ana and not(@select)] | l | note | orig | pb | sic | speaker | teiHeader | titlePage | trailer"></xsl:template>

<!-- abbr -->
<xsl:template match="abbr | byline | dateline | del | div[@type='contents'] | div[@type='notes'] | head[@ana and not(@select)] | l | note | orig | pb | sic | speaker | teiHeader | titlePage | trailer"></xsl:template>
    <!-- add -->
    <xsl:template match="//add"><xsl:apply-templates/></xsl:template>

    <!-- body -->
    <xsl:template match="body"><br/><xsl:apply-templates/></xsl:template>

    <!-- byline -->
<xsl:template match="abbr | byline | dateline | del | div[@type='contents'] | div[@type='notes'] | head[@ana and not(@select)] | l | note | orig | pb | sic | speaker | teiHeader | titlePage | trailer"></xsl:template>

    <!-- cb -->
    <xsl:template match="//cb">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top" width="100"/>
                <td valign="top">
                    <span class="layout">[column <span class="small-caps"><xsl:value-of select="@n"/></span>]</span>
                </td>
            </tr>
        </table>
    </xsl:template>

    <!-- corr -->
    <xsl:template match="corr"><xsl:apply-templates/></xsl:template>

    <!-- damage -->
    <xsl:template match="//damage"></xsl:template>


<!-- dateline -->
<xsl:template match=" dateline"></xsl:template>
    
   <!-- del -->
<xsl:template match="del"></xsl:template>
    
 <!-- div -->
    
    <xsl:template match="div">
    
    <xsl:choose>
  <xsl:when test="@type='contents'"></xsl:when>      
   <xsl:when test="@type='notes'"></xsl:when>        
     
  <xsl:when test="@type='poem' and descendant::reg[@ana='titled']">
            <tr><td width="100" valign="top" align="left">
                <xsl:value-of select="@type"/>
                </td>
           <td width="75" valign="top" align="left">
                    <xsl:value-of select="@n"/>
           </td>
                 <td width="125" valign="top" align="left"> 
                    <xsl:value-of select="@xml:id"/>
                </td>
               <td width="125" valign="top" align="left">
                    <xsl:value-of select="@ana"/>
                </td>
               <td width="75" valign="top" align="left">untitled</td>
                <td valign="top" align="left">
                <xsl:apply-templates/></td>
                               </tr>
   </xsl:when>
    

 <xsl:when test="@type='poem' and not(descendant::reg[@ana='titled'])">
            <tr><td width="100" valign="top" align="left">
                <xsl:value-of select="@type"/>
                </td>
           <td width="75" valign="top" align="left">
                    <xsl:value-of select="@n"/>
           </td>
                 <td width="125" valign="top" align="left"> 
                    <xsl:value-of select="@xml:id"/>
                </td>
               <td width="125" valign="top" align="left">
                    <xsl:value-of select="@ana"/>
                </td>
                <td width="75" valign="top" align="left">——</td>
                <td valign="top" align="left">
                <xsl:apply-templates/></td>
                               </tr>
   </xsl:when>
   
   
    <xsl:when test="@type='section' and not(child::reg[@ana='titled'])">
            <tr><td width="100" valign="top" align="left">
                <xsl:value-of select="@type"/>
                </td>
           <td width="75" valign="top" align="left">
                    <xsl:value-of select="@n"/>
           </td>
                 <td width="125" valign="top" align="left"> 
                    ———
                </td>
               <td width="125" valign="top" align="left">
                    <xsl:value-of select="@ana"/>
                   ——
                </td>
                <td width="75" valign="top" align="left">
                    ——
                   </td>
                    <td valign="top" align="left">
                <xsl:apply-templates/></td>
                               </tr>
   </xsl:when>
    
    
    <xsl:when test="@type='subsection' and not(child::reg[@ana='titled'])">
            <tr><td width="100" valign="top" align="left">
                <xsl:value-of select="@type"/>
                </td>
           <td width="75" valign="top" align="left">
                    <xsl:value-of select="@n"/>
           </td>
                 <td width="125" valign="top" align="left"> 
                    ———
                </td>
               <td width="250" valign="top" align="left">
                    <xsl:value-of select="@ana"/>
                   ——
                </td>
                <td width="75" valign="top" align="left">
                    ——
                   </td>
                    <td valign="top" align="left">
                <xsl:apply-templates/></td>
                               </tr>
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
        <br/>
        <xsl:apply-templates/>
    </xsl:template>

    <!-- expan -->
    <xsl:template match="expan"><xsl:apply-templates/></xsl:template>


    <!-- gap -->
    <xsl:template match="//gap">
        <span class="editorial">[<xsl:value-of select="@reason"/>]</span>
    </xsl:template>

    <xsl:template match=" head[@ana and not(@select)] | l | note | orig | pb | sic | speaker | teiHeader | titlePage | trailer"></xsl:template>
    <!-- head -->
    <xsl:template match="//head"><xsl:apply-templates/></xsl:template>
   
     <!-- item -->
    <xsl:template match="//item">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top" width="100">
                    <xsl:choose>
                        <!-- numbering for head unaltered -->
                        <xsl:when test="not(@ana) and not(descendant::del) and not(descendant::add)"></xsl:when>
                        <!-- numbering for head in process of completion -->
                        <xsl:when test="not(@ana) and descendant::del[@ana]"><span class="completion">item[[inc]</span></xsl:when>
                        <!-- numbering for item completed -->
                        <xsl:when test="not(@ana) and not(descendant::del[@ana]) and descendant::add[@ana='completion']"><span class="small-caps">item</span></xsl:when><!-- numbering for item in process of revision -->
                        <xsl:when test="@ana and not(@select)"><span class="revision"><span class="small-caps">item</span>(<xsl:value-of select="@ana"/>)</span></xsl:when>
                        <!-- numbering for item revised -->
                        <xsl:when test="@ana and @select"><span class="small-caps">item</span><span class="revision">(<xsl:value-of select="@ana"/>)</span></xsl:when>
                    </xsl:choose>
                </td>
                <td valign="top"><xsl:apply-templates/>
                 </td>
            </tr>
        </table>
    </xsl:template>


   
    <xsl:template match="l"></xsl:template>
   
   
   <xsl:template match="note | orig | pb | sic | speaker | teiHeader | titlePage | trailer"></xsl:template>

    <!-- lb -->

    <!-- line break -->
    <xsl:template match="//lb"></xsl:template>

    <!-- lg-->
    <xsl:template match="//lg"></xsl:template>

    <!-- list -->
    <xsl:template match="//list"></xsl:template>

   <!-- note -->   
        <xsl:template match="note"></xsl:template>
    
              
    <!-- orig -->

       <xsl:template match="//orig"></xsl:template>

    <!-- pb -->
      <xsl:template match="pb "></xsl:template>
    
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
            <!-- quotes:  ("...") -->
            <xsl:when test="@rend='dq'">"<xsl:apply-templates/>"</xsl:when>
            <!-- quotes:  ("...) -->
            <xsl:when test="@rend='ldq'">"<xsl:apply-templates/></xsl:when>
            <!-- quotes: (...") -->
            <xsl:when test="@rend='rdq'">
                <xsl:apply-templates/>"</xsl:when>
            <!-- quotes: (...) -->
            <xsl:when test="@rend='notq'">
                <xsl:apply-templates/></xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">Found a 'q' element with an unexpected value for 'rend'
                    attribute</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- ref -->
    <xsl:template match="//ref"/>

<!-- reg -->
    <xsl:template match="reg"><xsl:apply-templates/></xsl:template>

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
        
       <!-- sp -->
    <xsl:template match="//sp"></xsl:template>

    <!-- space -->
    <xsl:template match="//space">&#160;&#160;&#160;&#160;&#160;&#160;</xsl:template>

    <!-- speaker -->
    <xsl:template match="//speaker"></xsl:template>

    <!-- teiHeader -->
    <xsl:template match="//teiHeader"/>

<!-- title -->

<xsl:template match="title"><xsl:apply-templates/> </xsl:template>
     
       <!-- titlePage-->
    <xsl:template match="//titlePage"></xsl:template>

<!-- titlePart -->
<xsl:template match="titlePart"></xsl:template>

<!-- trailer -->
    <xsl:template match="//trailer"></xsl:template>

   </xsl:stylesheet>
