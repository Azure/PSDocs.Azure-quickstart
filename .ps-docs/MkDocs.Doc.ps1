# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Synopsis: A convention for adding metadata to be consumed by MkDocs.
Export-PSDocumentConvention 'AddMkDocsMeta' {
    $template = Get-Item -Path $PSDocs.Source.FullName;

    # Get parent directory paths where <templateName>/v<version>/template.json
    $version = $template.Directory.Name;
    $templateName = $template.Directory.Parent.Name;

    $metadata = $PSDocs.TargetObject | GetTemplateMetadata -Path $template.FullName;
    $Document.Metadata['title'] = $version;

    if ($metadata.ContainsKey('description')) {
        $Document.Metadata['description'] = $metadata.description;
    }

    if ($metadata.ContainsKey('name')) {
        $templateName = $metadata.name.Replace(' ', '-');
    }

    $PSDocs.Document.InstanceName = $version;
    $PSDocs.Document.OutputPath = Join-Path -Path $PSDocs.Document.OutputPath -ChildPath $templateName
}
