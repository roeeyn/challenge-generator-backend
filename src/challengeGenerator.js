// const map = require("awaity/map");

// const { each } = require("awaity/esm");

const { getExercises } = require("../db/utils.js");
const { createRepo } = require("./utils/createRepo.js");

module.exports.main = async (request, response) => {
  try {
    const { generationNumber } = request.query;

    if (!generationNumber) {
      return response.send({
        error: {
          message: "You need to provide 'generationNumber' in the url queries",
        },
      });
    }

    const difficulties = [
      "very easy",
      "easy",
      "medium",
      "hard",
      "very hard",
      "expert",
    ];

    const exercises = await Promise.all(
      difficulties.map(async difficulty => await getExercises(difficulty))
    );

    const exercisesFiles = await Promise.all(
      exercises.map((exercise, idx) => createRepo(exercise, idx))
    );

    return response.send({ files: exercisesFiles });
  } catch (error) {
    console.log(error);
    return response.send({
      error: {
        message: error,
      },
    });
  }
};
