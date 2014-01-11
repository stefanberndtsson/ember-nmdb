<script type="text/x-handlebars" data-template-name="Nmdb-person-page-links">
  <div class="row">
    <div {{bind-attr class="isMobile::panel isMobile::panel-default"}}>
      {{#unless isMobile}}
      <div class="panel-heading">
        <h4 class="panel-title">Links</h4>
      </div>
      {{/unless}}
      {{#each section in linkSections}}
      <div {{bind-attr class="isMobile:panel isMobile:panel-default isMobile:margin-bottom-large"}}>
	<div {{bind-attr class=":panel-body isMobile:no-padding"}}>
	  <h4 class="panel-heading">{{section.name}}</h4>
	  <div class="list-group no-margin">
	    {{#each section.links}}
	    <a target="_blank" class="list-group-item list-group-link-item list-group-link-item-single"
	       href="{{unbound linkHref}}">
	      <span class="pull-right glyphicon glyphicon-chevron-right list-group-link-arrow"/>
	      <h4>{{linkText}}</h4>
	    </a>
	    {{/each}}
	  </div>
	</div>
      </div>
      {{/each}}
    </div>
  </div>
</script>

