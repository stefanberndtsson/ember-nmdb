<script type="text/x-handlebars" data-template-name="Nmdb-person-page-images">
  <div class="row">
    <div class="panel panel-default">
      {{#unless isMobile}}
      <div class="panel-heading">
        <h4 class="panel-title">Images</h4>
      </div>
      {{/unless}}
      <div {{bind-attr class=":panel-body isMobile:no-padding:no-padding-top"}}>
	<div {{bind-attr class="isMobile::row"}} style="overflow: hidden">
	{{#if model.pageData.tmdb.profiles}}
	<h4 class="panel-heading">Profiles</h4>
        {{#each model.pageData.tmdb.profiles}}
        <span class="col-xs-6 col-sm-4 col-md-3 col-lg-3 panel">
	  <span class="profile-image">
	  <a target="_blank" href="{{unbound image_url}}" style="width: 100%;">
	    <img {{bind-attr src=image_url_medium}} />
	  </a>
	  </span>
	</span>
	{{#ifIndexMod 4}}<div class="clearfix visible-md visible-lg"></div>{{/ifIndexMod}}
	{{#ifIndexMod 3}}<div class="clearfix visible-sm"></div>{{/ifIndexMod}}
	{{#ifIndexMod 2}}<div class="clearfix visible-xs"></div>{{/ifIndexMod}}
        {{/each}}
	{{/if}}
	</div>
      </div>
    </div>
  </div>
</script>

