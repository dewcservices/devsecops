{{- if . }}
<h4>Vulnerabilities</h4>
{{- range . }}
<table>
    <tr>
        <th colspan="5">Vulnerabilities for <code>{{ escapeXML .Target }}</code></th>
    </tr>
    <tr>
        <th>Package</th>
        <th>ID</th>
        <th>Severity</th>
        <th>Installed Version</th>
        <th>Fixed Version</th>
    </tr>
    {{- if (eq (len .Vulnerabilities) 0) }}
    <tr>
        <td colspan="5">No Vulnerabilities found</td>
    </tr>
    {{- else }}
    {{- range .Vulnerabilities }}
    <tr>
        <td><code>{{ escapeXML .PkgName }}</code></td>
        <td>{{ escapeXML .VulnerabilityID }}</td>
        <td>{{ escapeXML .Severity }}</td>
        <td>{{ escapeXML .InstalledVersion }}</td>
        <td>{{ escapeXML .FixedVersion }}</td>
    </tr>
    {{- end }}
    {{- end }}
</table>
<br> <!-- Spacing between tables for different targets -->
{{- end }}

<h4>Misconfigurations</h4>
{{- range . }}
<table>
    <tr>
        <th colspan="5">Misconfigurations for <code>{{ escapeXML .Target }}</code></th>
    </tr>
    <tr>
        <th>Type</th>
        <th>ID</th>
        <th>Check</th>
        <th>Severity</th>
        <th>Message</th>
    </tr>
    {{- if (eq (len .Misconfigurations) 0) }}
    <tr>
        <td colspan="5">No Misconfigurations found</td>
    </tr>
    {{- else }}
    {{- range .Misconfigurations }}
    <tr>
        <td>{{ escapeXML .Type }}</td>
        <td>{{ escapeXML .ID }}</td>
        <td>{{ escapeXML .Title }}</td>
        <td>{{ escapeXML .Severity }}</td>
        <td>
          {{ escapeXML .Message }}
          <br><a href={{ escapeXML .PrimaryURL | printf "%q" }}>{{ escapeXML .PrimaryURL }}</a></br>
        </td>
    </tr>
    {{- end }}
    {{- end }}
</table>
<br> <!-- Spacing between tables for different targets -->
{{- end }}
{{- else }}
<h3>Trivy Returned Empty Report</h3>
{{- end }}