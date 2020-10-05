# frozen_string_literal: true

class ContentfulGateway
  def initialize(client)
    @client = client
  end

  def recipes_list(skip=0, limit=2)
    entries = @client.entries(
      content_type: 'recipe',
      select: [
        'sys.id',
        'fields.title',
        'fields.photo',
        'fields.tags',
        'fields.description',
        'fields.chef'
      ],
      skip: skip,
      limit: limit
    )
    entries
  end

  def get_recipe(id)
    entry = @client.entry(
      id,
      content_type: 'recipe',
      select: [
        'sys.id',
        'fields.title',
        'fields.photo',
        'fields.tags',
        'fields.description',
        'fields.chef'
      ]
    )
    entry
  end
end