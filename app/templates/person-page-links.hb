<script type="text/x-handlebars" data-template-name="Nmdb-person-page-links">
  {{#each linkSections}}
  <h4>{{name}}</h4>
  <ul>
    {{#each links}}
    <li><a target="_blank" href="{{unbound linkHref}}">{{linkText}}</a></li>
    {{/each}}
  </ul>
  {{/each}}
</script>

