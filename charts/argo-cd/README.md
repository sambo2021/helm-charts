# in chart.yaml >
- The version of our custom chart doesn't matter and can stay the same. 
- The version of the dependency matters and if you want to upgrade the chart, would be the place to do it. 
- The important thing is that we pull in the community-maintained argo-cd chart as a dependency
# in values.yaml >
- To override the chart values of a dependency, we have to place them under the dependency name. 
- Since our dependency in the Chart.yaml is called argo-cd, we have to place our values under the argo-cd: key. 
- If the dependency name would be abcd, we'd place the values under the abcd: key.
- Disable the dex component (integration with external auth providers).
- Disable the notifications controller (notify users about changes to application state).
- Disable the ApplicationSet controller (automated generation of Argo CD Applications).
- We start the server with the --insecure flag to serve the Web UI over HTTP. For this tutorial, we're using a local k8s server without TLS setup.s
