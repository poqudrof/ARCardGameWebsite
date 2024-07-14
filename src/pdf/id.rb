require 'json'

# The given list of roles
roles_json = '
{
  "data": [
    {
      "id": 8,
      "attributes": {
        "short_name": "e3d",
        "createdAt": "2023-09-22T16:23:34.510Z",
        "updatedAt": "2023-09-22T16:23:34.510Z",
        "publishedAt": "2023-09-22T16:23:34.507Z",
        "title": "Espaces 3D"
      }
    },
    {
      "id": 9,
      "attributes": {
        "short_name": "em",
        "createdAt": "2023-09-22T16:23:34.640Z",
        "updatedAt": "2023-09-22T16:23:34.640Z",
        "publishedAt": "2023-09-22T16:23:34.638Z",
        "title": "English Maths"
      }
    },
    {
      "id": 10,
      "attributes": {
        "short_name": "mdp",
        "createdAt": "2023-09-22T16:23:34.775Z",
        "updatedAt": "2023-09-22T16:23:34.775Z",
        "publishedAt": "2023-09-22T16:23:34.772Z",
        "title": "Montagne de problèmes"
      }
    },
    {
      "id": 11,
      "attributes": {
        "short_name": "p2d",
        "createdAt": "2023-09-22T16:23:34.953Z",
        "updatedAt": "2023-09-22T16:23:34.953Z",
        "publishedAt": "2023-09-22T16:23:34.950Z",
        "title": "Plaine de 2D"
      }
    },
    {
      "id": 12,
      "attributes": {
        "short_name": "vdn",
        "createdAt": "2023-09-22T16:23:35.123Z",
        "updatedAt": "2023-09-22T16:23:35.123Z",
        "publishedAt": "2023-09-22T16:23:35.121Z",
        "title": "Vallée des nombres"
      }
    }
  ],
  "meta": {
    "pagination": {
      "page": 1,
      "pageSize": 25,
      "pageCount": 1,
      "total": 5
    }
  }
}
'

# Parse the JSON string into a Ruby hash
roles_data = JSON.parse(roles_json)

# Function to get the role title from a complete ID
def get_role_title_from_id(complete_id, roles_data)
  short_name = complete_id[/^[a-z]+/]
  
  role = roles_data['data'].find { |r| r['attributes']['short_name'] == short_name }
  
  if role
    role['attributes']['title']
  else
    "Role not found"
  end
end

# Example complete IDs
complete_id_1 = "e3dcm1q_1"
complete_id_2 = "mdp54321_2"

# Get and print the roles
puts get_role_title_from_id(complete_id_1, roles_data) # => "Espaces 3D"
puts get_role_title_from_id(complete_id_2, roles_data) # 