require("dotenv").config();
/* HTTP Cloud Function.
 *
 * @param {Object} req Cloud Function request context.
 * @param {Object} res Cloud Function response context.
 */

exports.helloGET = async (req, res) => {
  // Secrets get pulled from .env locally and Google Secret Manager in Production
  const payload = process.env.MY_SECRET;

  res
    .status(200)
    .send(`Hello from Cloud Functions! Secret content: ${payload}`);
};
