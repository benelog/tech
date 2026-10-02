<#-- Comments via giscus (https://giscus.app), backed by GitHub Discussions.
     Rendered only when site.giscus.repo is set in jbake.properties. -->
<#if (config.site_giscus_repo?has_content)>
<section class="comments" id="comments">
  <script src="https://giscus.app/client.js"
          data-repo="${config.site_giscus_repo}"
          data-repo-id="${config.site_giscus_repo_id!''}"
          data-category="${config.site_giscus_category!'General'}"
          data-category-id="${config.site_giscus_category_id!''}"
          data-mapping="${config.site_giscus_mapping!'pathname'}"
          data-strict="1"
          data-reactions-enabled="1"
          data-emit-metadata="0"
          data-input-position="top"
          data-theme="${config.site_giscus_theme!'light'}"
          data-lang="en"
          data-loading="lazy"
          crossorigin="anonymous"
          async>
  </script>
  <noscript>Please enable JavaScript to view the <a href="https://giscus.app">comments powered by giscus</a>.</noscript>
</section>
</#if>
