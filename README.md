# Sources

* CF-Audit: <https://github.com/geometalab/cf_audit/tree/python3-and-docker>
* Conflation: <https://github.com/mapsme/osm_conflate>

## Usage (run) - example with ladestellen_elektromobilitaet_example

**input-data (profile/json)** -> conflate -> preview.json -> audit -> audit_file.json -> conflate (input) -> result_josm.xml -> JOSM Editor -> Upload changes to OSM

### Generating the to be validated json

```bash
docker compose -f conflator-charging_stations-example.yml build
mkdir -p ./data/chargingstations
docker compose -f conflator-charging_stations-example.yml run --rm conflator conflate profiles/ladestellen_elektromobilitaet_example.py -v -o /data/chargingstations/result.osm -c /data/chargingstations/preview.json
# example with json
docker compose -f conflator-charging_stations-example.yml run --rm conflator conflate -i myplace.json -v -o /data/chargingstations/result.osm -c /data/chargingstations/preview.json
```

### Validate the generated file

Start the audit tool:

```bash
docker compose build
docker compose up
# -> localhost:8080 -> create new projects
# if this button is missing, you are not an admin.
```

Give it a name, upload the generated `preview.json` file and start validating.

When done, use the audit file from `download audit` and put it into the data folder to create an JOSM compatible file to do the actual update in osm.

### Create JOSM compatible xml

...needed to edit in editors like JOSM and be added to OSM.

```bash
docker compose -f conflator-charging_stations-example.yml run --rm conflator conflate profiles/ladestellen_elektromobilitaet_example.py -v -a /data/chargingstations/audit_chargingstations.json  -o /data/chargingstations/result_josm.xml
```
