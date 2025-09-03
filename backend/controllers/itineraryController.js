const Itinerary = require('../models/Itinerary');

// @desc    Get user itineraries
// @route   GET /api/v1/itineraries
// @access  Private
exports.getItineraries = async (req, res, next) => {
  try {
    const itineraries = await Itinerary.find({ user: req.user.id });
    res.status(200).json({
      success: true,
      count: itineraries.length,
      data: itineraries
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Server Error'
    });
  }
};

// @desc    Create itinerary
// @route   POST /api/v1/itineraries
// @access  Private
exports.createItinerary = async (req, res, next) => {
  try {
    req.body.user = req.user.id;
    const itinerary = await Itinerary.create(req.body);
    res.status(201).json({
      success: true,
      data: itinerary
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Server Error'
    });
  }
};

// @desc    Update itinerary
// @route   PUT /api/v1/itineraries/:id
// @access  Private
exports.updateItinerary = async (req, res, next) => {
  try {
    let itinerary = await Itinerary.findById(req.params.id);

    if (!itinerary) {
      return res.status(404).json({
        success: false,
        message: 'Itinerary not found'
      });
    }

    // Make sure user owns the itinerary
    if (itinerary.user.toString() !== req.user.id) {
      return res.status(401).json({
        success: false,
        message: 'Not authorized to update this itinerary'
      });
    }

    itinerary = await Itinerary.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
      runValidators: true
    });

    res.status(200).json({
      success: true,
      data: itinerary
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Server Error'
    });
  }
};

// @desc    Delete itinerary
// @route   DELETE /api/v1/itineraries/:id
// @access  Private
exports.deleteItinerary = async (req, res, next) => {
  try {
    const itinerary = await Itinerary.findById(req.params.id);

    if (!itinerary) {
      return res.status(404).json({
        success: false,
        message: 'Itinerary not found'
      });
    }

    // Make sure user owns the itinerary
    if (itinerary.user.toString() !== req.user.id) {
      return res.status(401).json({
        success: false,
        message: 'Not authorized to delete this itinerary'
      });
    }

    await Itinerary.findByIdAndDelete(req.params.id);

    res.status(200).json({
      success: true,
      message: 'Itinerary deleted successfully'
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Server Error'
    });
  }
};