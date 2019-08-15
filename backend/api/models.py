from sqlalchemy import Integer, BigInteger, Column, String, Numeric
from tornado_sqlalchemy import declarative_base

DeclarativeBase = declarative_base()


class DotaHeroes(DeclarativeBase):
    __tablename__ = 'dota_heroes'

    id = Column(Integer, primary_key=True)
    name = Column(String(255), unique=True)
    short_name = Column(String(255), unique=True)
    display_name = Column(String(255), unique=True)


class DotaItem(DeclarativeBase):
    __tablename__ = 'dota_items'

    id = Column(Integer, primary_key=True)
    name = Column(String(255), unique=True)
    short_name = Column(String(255), unique=True)
    display_name = Column(String(255), unique=True)


class GroupStage(DeclarativeBase):
    __tablename__ = 'group_stage'

    team_id = Column(BigInteger, primary_key=True)
    group_number = Column(Integer, nullable=False)
    position = Column(Integer, default=1, nullable=False)
    color = Column(String(255), nullable=False)
    wins = Column(Integer, default=0, nullable=False)
    loses = Column(Integer, default=0, nullable=False)

    def __init__(self, team_id):
        self.team_id = team_id
        self.group_number = 1
        self.position = 1
        self.color = "light_grey"
        self.wins = 0
        self.loses = 0


class DotaProTeam(DeclarativeBase):
    __tablename__ = 'dota_pro_teams'

    id = Column(BigInteger, primary_key=True)
    name = Column(String(255), nullable=False)


class DotaProPlayer(DeclarativeBase):
    __tablename__ = 'dota_pro_players'

    account_id = Column(BigInteger, primary_key=True)
    team_id = Column(BigInteger)
    nickname = Column(String(255), nullable=False, default="")
    name = Column(String(255), nullable=False, default="")
    position = Column(Integer, nullable=False,default=0)


class DotaJoinGlobalHeroes(DeclarativeBase):
    __tablename__ = 'join_global_hero'

    hero_id = Column(Integer, primary_key=True)
    short_name = Column(String(255), unique=True)
    display_name = Column(String(255), unique=True)
    nb_pick = Column(Numeric())
    nb_ban = Column(Numeric())
    nb_match = Column(Numeric())
    mean_is_win = Column(Numeric())


class DotaJoinGlobal(DeclarativeBase):
    __tablename__= 'join_global'

    nb_match = Column(Numeric(), primary_key=True)
    mean_radiant_win = Column(Numeric())
    mean_duration = Column(Numeric())


class DotaJoinGlobalTeam(DeclarativeBase):
    __tablename__ = 'join_global_team'

    team_id = Column(BigInteger, primary_key=True)
    team_name = Column(String(255))
    nb_match = Column(Numeric())
    win_duration = Column(Numeric())
    lose_duration = Column(Numeric())
    mean_pct_bounty = Column(Numeric())


class DotaJoinGlobalTeamHero(DeclarativeBase):
    __tablename__ = 'join_global_team_hero'

    team_id = Column(BigInteger, primary_key=True)
    team_name = Column(String(255))
    hero_id = Column(Integer, primary_key=True)
    hero_short_name = Column(String(255))
    hero_display_name = Column(String(255))
    nb_match = Column(Numeric())
    nb_pick = Column(Numeric())
    nb_ban_against = Column(Numeric())
    mean_is_win = Column(Numeric())
