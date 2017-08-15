# README

## Summary
This is a simple API where you can play blackjack 

## Demonstration
You can overview functions with following host
https://blackjack-ix.herokuapp.com/

## Create a game API
### Summary
API to create a new game 

### Endpoint

```
POST /v1/games
```

### Request params

Following params are required and should be passed in as JSON format.

| param | | required | type | description | sample value |
| --- | --- | --- | --- | --- | --- |
| games | | required | {} | Should contain player_count and deck_count |  |
|  | player_count | required | Integer | Specify number of players | 3 |
|  | deck_count | required | Integer | Specify number of deck to be used in game | 2 |

#### Sample request json
```
{
  "games": {
    "player_count": 3,
    "deck_count": 2
  }
}
```

### Response

Response is given in JSON format and has parameters as follows

| param | type | description | sample value |
| --- | --- | --- | --- |
| id | Integer | id of the new game | 1 |
| status | String | Status of the game. "active" or "inactive" | active |
| players | [] | Include status of each players | |
| dealer | {} | Status of dealer | |

and each player/dealer has following paramters

| param | type | description | sample value |
| --- | --- | --- | --- |
| name | String | Name of player | Player11 |
| status | String | Status of the player. Available statuses are: "playing", "win", "lose", "push" and "confirmed". | playing |
| score | Integer or String | Score of player's hand. If score is hidden, `"-"` will be given | 20 |
| hand | [String] | Cards in hand  | ["8-club","3-club"] |

## Deal API
### Summary
API to deal the game 

### Endpoint

```
POST /v1/games/:id/deal
```

### Request params

Following params are required and should be passed in as JSON format.

| param | | required | type | description | sample value |
| --- | --- | --- | --- | --- | --- |
| game | | required | {} | Should contain player_count and deck_count |  |
|  | player_id | required | Integer | Specify player id | 3 |
|  | command | required | String | Specify command you want to take. Only available "hit" or "stand" for now | hit |

#### Sample request json
```
{
  "game": {
    "player_id": 1,
    "command": "hit"
  }
}
```

### Response

Response is given in JSON format and has parameters as follows

| param | type | description | sample value |
| --- | --- | --- | --- |
| id | Integer | id of the new game | 1 |
| status | String | Status of the game. "active" or "inactive" | active |
| player | {} | Status of specified player | |
| dealer | {} | Status of dealer | |


## Show a game API
### Summary
API to show detail of given game_id

### Endpoint

```
GET /v1/games/:id
```

### Request params

Following params are required.

| param |required | type | description | sample value |
| --- |--- | --- | --- | --- |
| id | required | Integer | game id | 1 |

### Response

Response is given in JSON format and has parameters as follows

| param | type | description | sample value |
| --- | --- | --- | --- |
| id | Integer | id of the new game | 1 |
| status | String | Status of the game. "active" or "inactive" | active |
| players | [] | Include status of each players | |
| dealer | {} | Status of dealer | |

## Show winners of a game API
### Summary
API to show winners of given game_id

### Endpoint

```
GET /v1/games/:id/winner
```

### Request params

Following params are required.

| param |required | type | description | sample value |
| --- |--- | --- | --- | --- |
| id | required | Integer | game id | 1 |

### Response

Response is given in JSON format and has parameters as follows

| param | type | description | sample value |
| --- | --- | --- | --- |
| id | Integer | id of the new game | 1 |
| status | String | Status of the game. "active" or "inactive" | active |
| winner | [] | Names of winners | |


## Finish game API
### Summary
API to deactivate game for the given game_id

### Endpoint

```
PUT /v1/games/:id/finish
```

### Request params

Following params are required.

| param |required | type | description | sample value |
| --- |--- | --- | --- | --- |
| id | required | Integer | game id | 1 |

### Response

Response is given in JSON format and has parameters as follows

| param | type | description | sample value |
| --- | --- | --- | --- |
| id | Integer | id of the new game | 1 |
| status | String | Status of the game. "active" or "inactive" | active |
| players | [] | Include status of each players | |
| dealer | {} | Status of dealer | |

### Note
