<script type="text/x-handlebars" data-template-name="Nmdb-person-page-publicity">
  {{#each group in pageData}}
  <h3>{{group.display}}</h3>
  {{#if group.value}}
  {{group.value}}
  {{else}}
  <ul>
    {{#each entry in group.values}}
    <li>{{decodeLinks entry.value entry.links}}</li>
    {{/each}}
  </ul>
  {{/if}}
  {{/each}}
</script>

