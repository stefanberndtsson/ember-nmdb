<script type="text/x-handlebars" data-template-name="Nmdb-components/bootstrap-indicator">
  <a href="javascript:void(0);">{{typeDisplay}}</a>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-components/section-dropdown-option">
  {{section.display}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-components/section-link">
  {{#if section.disabled}}
  <a href="javascript:void(0);">{{section.display}}</a>
  {{else}}
  {{#link-to router modelId section.name queryParams=false}}{{section.display}}{{/link-to}}
  {{/if}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-components/section-menu">
  <ul class="nav well well-sm section-menu">
    <li class="disabled"><a href="javascript:void(0);"><h4>{{sectionMenuTitle}}</h4></a></li>
    {{#each section in sections}}
    {{section-link router=router section=section modelId=modelId currentSection=currentSection}}
    {{/each}}
  </ul>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-components/section-menu-dropdown">
  <div class="row"><h4>
  {{section-dropdown target=target router=router sections=sections 
                     modelId=modelId currentSection=currentSection action=menuTransition}}
  </h4></div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-components/section-dropdown">
  {{#each section in sections}}
  {{section-dropdown-option router=router section=section modelId=modelId currentSection=currentSection}}
  {{/each}}
</script>
