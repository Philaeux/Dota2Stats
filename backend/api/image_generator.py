import os
import shutil


class ImageGenerator:

    def __init__(self, assets_root):
        self.assets_root = assets_root
        self.generated_root = os.path.join(assets_root, "generated")
        self.teams_data = os.path.join(assets_root, "teams")

    def generate_static(self, team_id):
        generated_path = os.path.join(self.generated_root, "static_teams-" + team_id + ".png")
        if os.path.exists(generated_path):
            os.remove(generated_path)

        source_path = os.path.join(self.teams_data, team_id, "static_teams-" + team_id + ".png")
        if os.path.exists(source_path):
            shutil.copy(source_path, generated_path)
