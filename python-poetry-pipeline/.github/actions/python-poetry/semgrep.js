var fs = require("fs");
var data = JSON.parse(fs.readFileSync("./semgrep", "utf8"));

html = "<h1>Semgrep Results :test_tube:</h1>";

for (var i = 0; i < data.results.length; i++) {
  if (data.results[i].extra.severity == "ERROR" || data.results[i].extra.severity == "HIGH" || data.results[i].extra.severity == "CRITICAL") {
    html += "<table>";
    html += " <tr> <th>likelihood</th> <th>Implact</th> <th>CWE</th> <th>path</th> <th>start:end line</th> <th>technology</th> </tr>";
    html += "<td>" + data.results[i].extra.metadata.likelihood + "</td>";
    html += "<td>" + data.results[i].extra.metadata.impact	+ "</td>";
    html += "<td>" + '<a href="' + data.results[i].extra.metadata.references[0] + '">' + data.results[i].extra.metadata.cwe[0] + "</a> "+ "</td>";
    html += "<td>" + JSON.stringify(data.results[i].path) + "</td>";
    html += "<td>" + JSON.stringify(data.results[i].start) + ":" + JSON.stringify(data.results[i].end) + "</td>";
    html += "<td>" + JSON.stringify(data.results[i].extra.metadata.technology) + "</td>";
    html += "</table>";
    html += "<p>" + data.results[i].extra.message + "</p>";
    html += "<br>";
  }
}
console.log(html);
